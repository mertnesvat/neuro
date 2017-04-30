//
//  MainViewController.m
//  neuro
//
//  Created by Mert Neşvat on 30/04/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "MainViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "Singleton.h"

@interface MainViewController () <CBCentralManagerDelegate>
@property IXNMuseManagerIos * manager;
@property (weak, nonatomic) IXNMuse * muse;
@property (nonatomic) NSMutableArray* logLines;
@property (nonatomic) BOOL lastBlink;
@property (strong,nonatomic) NSMutableArray *values;
@property (strong,nonatomic) NSMutableArray *values2;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    if (!self.manager) {
        self.manager = [IXNMuseManagerIos sharedManager];
    }
    [self setMuseManager];
    
    [self.manager startListening];
    
    [Singleton shared].manager = self.manager;
    

    

    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setGraph];
}
- (void)setGraph{
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.values addObject:@([self getRandomFloat])];
        [self.values removeObjectsInRange:NSMakeRange(0, 1)];
        [self.values2 addObject:@([self getRandomFloat])];
        [self.values2 removeObjectsInRange:NSMakeRange(0, 1)];
//        NSDate *newDate = [self dateForGraphAfterDate:(NSDate *)[self.arrayOfDates lastObject]];
//        [self.arrayOfDates addObject:newDate];
//        [self.arrayOfDates removeObjectsInRange:NSMakeRange(0, 1)];
//
//        [self.myGraph reloadGraph];
//        [self.myGraph2 reloadGraph];

    }];

}

- (NSDate *)dateForGraphAfterDate:(NSDate *)date {
    NSTimeInterval secondsInTwentyFourHours = 24 * 60 * 60;
    NSDate *newDate = [date dateByAddingTimeInterval:secondsInTwentyFourHours];
    return newDate;
}


- (void)setMuseManager{
    self.manager = [IXNMuseManagerIos sharedManager];
    [self.manager setMuseListener:self];

    [[IXNLogManager instance] setLogListener:self];

}
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {

}

- (void)receiveMuseDataPacket:(IXNMuseDataPacket *)packet
                         muse:(IXNMuse *)muse {
    if (packet.packetType == IXNMuseDataPacketTypeAlphaAbsolute ||
        packet.packetType == IXNMuseDataPacketTypeEeg) {
//        [self log:@"%5.2f %5.2f %5.2f %5.2f",
//         [packet.values[IXNEegEEG1] doubleValue],
//         [packet.values[IXNEegEEG2] doubleValue],
//         [packet.values[IXNEegEEG3] doubleValue],
//         [packet.values[IXNEegEEG4] doubleValue]];
        if (packet.packetType == IXNMuseDataPacketTypeAlphaAbsolute) {
            [self.values addObject:@([packet.values[2] doubleValue] * 100)];
            [self.values2 addObject:@([packet.values[1] doubleValue] * 100)];
            [self.values removeObjectsInRange:NSMakeRange(0, 1)];
            [self.values2 removeObjectsInRange:NSMakeRange(0, 1)];
            
//            [self.myGraph reloadGraph];
//            [self.myGraph2 reloadGraph];
        }
        
    }
}

- (void)receiveMuseArtifactPacket:(IXNMuseArtifactPacket *)packet
                             muse:(IXNMuse *)muse {
    if (packet.blink && packet.blink != self.lastBlink) {
//        [self log:@"blink detected"];
    }
    self.lastBlink = packet.blink;
}

- (void)log:(NSString *)fmt, ... {
    va_list args;
    va_start(args, fmt);
    NSString *line = [[NSString alloc] initWithFormat:fmt arguments:args];
    va_end(args);
    NSLog(@"%@", line);
    [self.logLines insertObject:line atIndex:0];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self.logView setText:[self.logLines componentsJoinedByString:@"\n"]];
    });
}
- (float)getRandomFloat {
    float i1 = (float)(arc4random() % 1000000) / 100 ;
    return i1;
}

- (void)receiveMuseConnectionPacket:(IXNMuseConnectionPacket *)packet
                               muse:(IXNMuse *)muse {
    NSString *state;
    switch (packet.currentConnectionState) {
        case IXNConnectionStateDisconnected:
            state = @"disconnected";
            break;
        case IXNConnectionStateConnected:
            state = @"connected";
            break;
        case IXNConnectionStateConnecting:
            state = @"connecting";
            break;
        case IXNConnectionStateNeedsUpdate: state = @"needs update"; break;
        case IXNConnectionStateUnknown: state = @"unknown"; break;
        default: NSAssert(NO, @"impossible connection state received");
    }
    [self log:@"connect: %@", state];
}

-(void)receiveLog:(IXNLogPacket *)log{
    [self log:@"%@: %llu raw:%d %@", log.tag, log.timestamp, log.raw, log.message];
}

#pragma mark - CONNECTION
-(void)museListChanged{
    //connect to muse
    NSArray * muses = [self.manager getMuses];
    if ([muses count] > 0) {
        IXNMuse * muse = [muses firstObject];
        self.muse = muse;
        [Singleton shared].muse = self.muse;

        [self connect];
        
    }
}

- (void) connect {
    [self.muse registerConnectionListener:self];
    [self.muse registerDataListener:self
                               type:IXNMuseDataPacketTypeArtifacts];
    [self.muse registerDataListener:self
                               type:IXNMuseDataPacketTypeAlphaAbsolute];
    /*
     [self.muse registerDataListener:self
     type:IXNMuseDataPacketTypeEeg];
     */
    [self.muse runAsynchronously];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)applicationWillResignActive {
    NSLog(@"disconnecting before going into background");
    [self.muse disconnect];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
