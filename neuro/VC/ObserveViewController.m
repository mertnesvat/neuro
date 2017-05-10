//
//  ObserveViewController.m
//  neuro
//
//  Created by Mert Neşvat on 01/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "ObserveViewController.h"


@interface ObserveViewController () <CBCentralManagerDelegate, ChartViewDelegate>
@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property int timeCounter;
@end

@implementation ObserveViewController
NSDictionary *valuesDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.optionsDataset = @{}.mutableCopy;
    valuesDic = @{}.mutableCopy;
    _timeCounter = 0;
    
    self.selectedOptions = @{ @"8" : @"IXNMuseDataPacketTypeAlphaAbsolute"};
    
    [self setMuseManager];
    self.muse = [Singleton shared].muse;
 //   [self setData];
    [self setChartDetails];
    
    [self.manager startListening];

//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(addNewData) userInfo:nil repeats:YES];

    
}

- (void)setMuseManager{
    self.manager = [IXNMuseManagerIos sharedManager];
    [self.manager setMuseListener:self];
    
    [[IXNLogManager instance] setLogListener:self];
    
}
- (UIColor *)randomColor{
    double randomVal1 = (double) (arc4random_uniform(200)) + 50;
    double randomVal2 = (double) (arc4random_uniform(200)) + 50;
    double randomVal3 = (double) (arc4random_uniform(200)) + 50;
    UIColor *color = [UIColor colorWithRed:randomVal1/255.f green:randomVal2/255.f blue:randomVal3/255.f alpha:1.f];

    return color;
}
- (void)setData
{
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];

    NSArray *dataPoints = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    NSArray *values = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    
    for (NSString *key in self.selectedOptions) {
        NSMutableArray *xVals = [[NSMutableArray alloc] init];
        for (int i=0;i<dataPoints.count;i++)
        {
            [xVals addObject:[dataPoints objectAtIndex:i]];
        }
        
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        for (int i=0;i<values.count;i++)
        {
            int val = [([values objectAtIndex:i])intValue];
            [yVals addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
        }
        
        LineChartDataSet *set1 = nil;
        set1 = [[LineChartDataSet alloc] initWithValues:yVals label:self.selectedOptions[key]];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[self randomColor]];
        [set1 setCircleColor:UIColor.whiteColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [self randomColor];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
        
        [dataSets addObject:set1];
    }
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setValueTextColor:UIColor.whiteColor];
    [data setValueFont:[UIFont systemFontOfSize:9.f]];
    
    _chartView.data = data;

}

- (void)LineChartDataSetAddAttributes:(LineChartDataSet *)set1{

    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[self randomColor]];
    [set1 setCircleColor:UIColor.whiteColor];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.fillAlpha = 65/255.0;
    set1.fillColor = [self randomColor];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set1.drawCircleHoleEnabled = NO;

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
    leftAxis.axisMaximum = 200.0;
    leftAxis.axisMinimum = 0.0;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = YES;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.labelTextColor = UIColor.redColor;
    rightAxis.axisMaximum = 900.0;
    rightAxis.axisMinimum = -200.0;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.granularityEnabled = NO;
    
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addNewData) userInfo:nil repeats:YES];

}

- (void)addNewData:(double)randomVal{
    
    for (LineChartDataSet *set in self.chartView.data.dataSets){
        NSMutableArray *values = set.values.mutableCopy;
        ChartDataEntry *c1 = [values lastObject];
        [values addObject:[[ChartDataEntry alloc] initWithX:c1.x+1 y:randomVal]];
        
        if ([values count] > 9) {
            [values removeObjectsInRange:NSMakeRange(0, 1)];
        }
        
        set.values = values.copy;

        
    }
    
    
    [_chartView.data notifyDataChanged];
    [_chartView notifyDataSetChanged];
    
}

- (void)addAllDataSets{
    int a = 0;
    for (NSString *key in self.selectedOptions) {
        LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:@[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1] label:self.selectedOptions[key]];
        
        set = (LineChartDataSet *)_chartView.data.dataSets[a];
    }
    
    /*
    
    LineChartDataSet *set1 = nil, *set2 = nil, *set3 = nil;
    
    set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
    set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
    set3 = (LineChartDataSet *)_chartView.data.dataSets[2];
    
    NSArray *chart1 = set1.values;
    NSArray *chart2 = set2.values;
    NSArray *chart3 = set3.values;
    
    double val = (double) (arc4random_uniform(100)) + 50;
    NSMutableArray *newC1 = chart1.mutableCopy;
    ChartDataEntry *c1 = [newC1 lastObject];
    [newC1 addObject:[[ChartDataEntry alloc] initWithX:c1.x+1 y:val]];
    [newC1 removeObjectsInRange:NSMakeRange(0, 1)];
    
    double val2 = (double) (arc4random_uniform(100)) + 50;
    NSMutableArray *newC2 = chart2.mutableCopy;
    ChartDataEntry *c2 = [newC2 lastObject];
    [newC2 addObject:[[ChartDataEntry alloc] initWithX:c2.x+1 y:val2]];
    [newC2 removeObjectsInRange:NSMakeRange(0, 1)];
    
    double val3 = (double) (arc4random_uniform(100)) + 50;
    NSMutableArray *newC3 = chart3.mutableCopy;
    ChartDataEntry *c3 = [newC3 lastObject];
    [newC3 addObject:[[ChartDataEntry alloc] initWithX:c3.x+1 y:val3]];
    [newC3 removeObjectsInRange:NSMakeRange(0, 1)];
    
    set1.values = newC1;
    set2.values = newC2;
    set3.values = newC3;*/
    

    
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
    
    [self addNewDataFromValues:packet.values withName:@"hello"];
}

-(void)addNewDataFromValues:(NSArray *)values withName:(NSString *)title{
    _timeCounter++;
    int sensorNumber = 0;
    
    if (_chartView.data.dataSets) {
        for (LineChartDataSet *set in _chartView.data.dataSets) {
            NSArray *comp = [set.label componentsSeparatedByString:@"-"];
            NSMutableArray *oldValues = set.values.mutableCopy;
            
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *row = [f numberFromString:comp[1]];
            
            NSNumber *val = values[row.intValue];
            double v = [val doubleValue];
            [oldValues addObject:[[ChartDataEntry alloc] initWithX:_timeCounter y:v*100]];
            
            if ([oldValues count] > 20) {
                [oldValues removeObjectAtIndex:0];
            }
            
            set.values = oldValues;
        }
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];

    }else{
        NSMutableArray *dataSetArr = @[].mutableCopy;
        for (NSNumber * val in values) {
            double v = [val doubleValue];
            NSString *combined = [NSString stringWithFormat:@"%@-%d",title,sensorNumber];
            LineChartDataSet *chartDataSet = [[LineChartDataSet alloc] initWithValues:@[[[ChartDataEntry alloc] initWithX:_timeCounter y:v]] label:combined];
            [self LineChartDataSetAddAttributes:chartDataSet];
            sensorNumber++;
            [dataSetArr addObject:chartDataSet];
        }
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSetArr];
        _chartView.data = data;
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];

    }
    
    // ChartDataEntry < LineChartDataSet < LineChartData < _chartView.data
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

    for (NSString *str in [self.selectedOptions allKeys]) {
        long num = str.longLongValue;
        
        [self.muse registerDataListener:self
                                   type:IXNMuseDataPacketTypeAlphaAbsolute];
    }
    [self.muse registerDataListener:self
                               type:IXNMuseDataPacketTypeAlphaAbsolute];

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
