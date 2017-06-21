//
//  ObserveViewController.m
//  neuro
//
//  Created by Mert Neşvat on 01/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "ObserveViewController.h"
#import "UIColor+Color.h"

@interface ObserveViewController () <CBCentralManagerDelegate, ChartViewDelegate>
@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property int timeCounter;
@end

@implementation ObserveViewController

int64_t a = 1;
NSDictionary *valuesDic;

- (IBAction)btnSavePressed:(id)sender {
    [self saveProfile];
}
- (IBAction)btnLoadPressed:(id)sender {
    [self loadData];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.optionsDataset = @{}.mutableCopy;
    valuesDic = @{}.mutableCopy;
    _timeCounter = 0;
    
//    self.selectedOptions = @{ @"8" : @"IXNMuseDataPacketTypeAlphaAbsolute"};
    UINib *nib = [UINib nibWithNibName:@"GraphCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"graphCell"];
    
    [self setMuseManager];
    self.muse = [Singleton shared].muse;
    [self setChartDetails];
    
    [self.manager startListening];
    
    _testArrayOfDataPacket = @[].mutableCopy;

    
    
    //fake initialize;
//    _multi = [[MMultipleLinesDataPacket alloc] initWithIXNMuseDataPacketWithName:@"test"];

    
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(fakeReceiver) userInfo:nil repeats:YES];

    
}


- (void)fakeReceiver{
    
    a++;
    NSArray *values = @[[@0 randomNumber],[@0 randomNumber],[@0 randomNumber],[@0 randomNumber] ];
    IXNMuseDataPacket *fakePacket = [IXNMuseDataPacket makePacket:IXNMuseDataPacketTypeAlphaAbsolute timestamp:a values:values];
    
    [_multi addIXNMuseDataPacketToTheLines:fakePacket];
    _chartView.data = _multi.data;
    [_chartView.data notifyDataChanged];
    [_chartView notifyDataSetChanged];
    
}

- (void)setMuseManager{
    self.manager = [IXNMuseManagerIos sharedManager];
    [self.manager setMuseListener:self];
    
    [[IXNLogManager instance] setLogListener:self];
    
}

- (void)setChartDetails{
//    _chartView.delegate = self;
    [_chartView setScaleEnabled:YES];
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.pinchZoomEnabled = YES;
    
    _chartView.backgroundColor = [UIColor colorWithWhite:204/255.f alpha:1.f];


    ChartLegend *l = _chartView.legend;
    l.form = ChartLegendFormLine;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.textColor = UIColor.whiteColor;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
    xAxis.labelTextColor = UIColor.whiteColor;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = NO;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelTextColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    leftAxis.axisMaximum = 2;
    leftAxis.axisMinimum = 0.0;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = YES;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.labelTextColor = UIColor.redColor;
    rightAxis.axisMaximum = +1.0;
    rightAxis.axisMinimum = -1.0;
    rightAxis.drawGridLinesEnabled = YES;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Connection Listener

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
}
#pragma mark - Data Listener

-(void)receiveMuseDataPacket:(IXNMuseDataPacket *)packet muse:(IXNMuse *)muse{
    
    [_multi addIXNMuseDataPacketToTheLines:packet];
    
    NSString *type = [@"" formatIXNDataPacketTypeToString:packet.packetType];
    MMultipleLinesDataPacket *mLines = [self findMultipleLinesPacketFromTitle:type];
    
    [mLines addIXNMuseDataPacketToTheLines:packet];
    
    [self.tableView reloadData];
}

-(void)receiveMuseArtifactPacket:(IXNMuseArtifactPacket *)packet muse:(IXNMuse *)muse{

    
}

#pragma mark - Log

-(void)receiveLog:(IXNLogPacket *)log{
    [self log:@"%@: %llu raw:%d %@", log.tag, log.timestamp, log.raw, log.message];
}

#pragma mark - muse Listener
- (void)museListChanged{
    //connect to muse
    NSArray * muses = [self.manager getMuses];
    if ([muses count] > 0) {
        IXNMuse * muse = [muses firstObject];
        self.muse = muse;
        [Singleton shared].muse = self.muse;
        
        [self connect];
        
    }
}

#pragma mark - Bluetooth


- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}

- (void) connect {
    [self.muse registerConnectionListener:self];
    NSMutableArray *selectedOptionsMultipleLines = @[].mutableCopy;
    for (NSString *str in [self.selectedOptions allKeys]) {
        long num = str.longLongValue;
        
        [self.muse registerDataListener:self
                                   type:num];
        NSString *title = [@"" fetchMuseStringFromInt:[NSNumber numberWithLong:num]];
        MMultipleLinesDataPacket *packet = [[MMultipleLinesDataPacket alloc] initWithIXNMuseDataPacketWithName:title];
        
        [selectedOptionsMultipleLines addObject:packet];
    }
    _multi = [[MMultipleLinesDataPacket alloc] initWithIXNMuseDataPacketWithName:@"test"];
    
    
    _lines = selectedOptionsMultipleLines.copy;
    /*
     [self.muse registerDataListener:self
     type:IXNMuseDataPacketTypeEeg];
     */
    [self.muse runAsynchronously];
}



#pragma mark - TableView

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_selectedOptions.allKeys count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GraphCell *cell = [tableView dequeueReusableCellWithIdentifier:@"graphCell"];
    
    cell.chartView.data = _lines[indexPath.row].data;
    [cell.chartView.data notifyDataChanged];
    [cell.chartView notifyDataSetChanged];
    
    return cell;
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (MMultipleLinesDataPacket *)findMultipleLinesPacketFromTitle:(NSString *)title{
    for (MMultipleLinesDataPacket *bundle in _lines) {
        if ([bundle.title isEqualToString:title]) {
            
            return bundle;
        }
    }
    
    return nil;
}


-(NSString*)saveFilePath    {
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathString = [[pathArray objectAtIndex:0] stringByAppendingPathComponent:@"data"];
    //NSString *pathString = [[NSBundle mainBundle]pathForResource:@"Profile" ofType:@"plist"];
    return pathString;
    
}

-(void)saveProfile{
    
    
    NSMutableData *pData = [[NSMutableData alloc]init];
    
    NSString *path = [self saveFilePath];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:pData];
    [_testArrayOfDataPacket encodeWithCoder:archiver];
    [archiver finishEncoding];
    [pData writeToFile:path atomically:YES];
    
}


-(void)loadData{
    
    NSString* path = [self saveFilePath];
    //NSLog(path);
    NSMutableData *pData = [[NSMutableData alloc]initWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:pData];
    _testArrayOfDataPacket = [[NSMutableArray alloc] initWithCoder:unArchiver];
    //NSLog(@"%@",data.firstName);
    [unArchiver finishDecoding];
    
}


@end
