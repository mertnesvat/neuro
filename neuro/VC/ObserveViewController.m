//
//  ObserveViewController.m
//  neuro
//
//  Created by Mert Neşvat on 01/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "ObserveViewController.h"

@interface ObserveViewController () <CBCentralManagerDelegate>

@end

@implementation ObserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Connection Listener

-(void)receiveMuseConnectionPacket:(IXNMuseConnectionPacket *)packet muse:(IXNMuse *)muse{
    
}

#pragma mark - Data Listener

-(void)receiveMuseDataPacket:(IXNMuseDataPacket *)packet muse:(IXNMuse *)muse{
    if (packet.packetType == IXNMuseDataPacketTypeAlphaAbsolute ||
        packet.packetType == IXNMuseDataPacketTypeEeg) {
        //        [self log:@"%5.2f %5.2f %5.2f %5.2f",
        //         [packet.values[IXNEegEEG1] doubleValue],
        //         [packet.values[IXNEegEEG2] doubleValue],
        //         [packet.values[IXNEegEEG3] doubleValue],
        //         [packet.values[IXNEegEEG4] doubleValue]];
        if (packet.packetType == IXNMuseDataPacketTypeAlphaAbsolute) {
//            [self.values addObject:@([packet.values[2] doubleValue] * 100)];
//            [self.values2 addObject:@([packet.values[1] doubleValue] * 100)];
//            [self.values removeObjectsInRange:NSMakeRange(0, 1)];
//            [self.values2 removeObjectsInRange:NSMakeRange(0, 1)];
            
            //            [self.myGraph reloadGraph];
            //            [self.myGraph2 reloadGraph];
        }       
        
    }
    
}
-(void)receiveMuseArtifactPacket:(IXNMuseArtifactPacket *)packet muse:(IXNMuse *)muse{

}

#pragma mark - Log

-(void)receiveLog:(IXNLogPacket *)log{
    
}

#pragma mark - muse Listener

-(void)museListChanged{

}

#pragma mark - Bluetooth

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}

- (void) connect {
    [self.muse registerConnectionListener:self];

    
    for (NSString *str in [self.selectedOptions allKeys]) {
        long num = str.longLongValue;
        [self.muse registerDataListener:self
                                   type:num];
    }
    /*
     [self.muse registerDataListener:self
     type:IXNMuseDataPacketTypeEeg];
     */
    [self.muse runAsynchronously];
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
