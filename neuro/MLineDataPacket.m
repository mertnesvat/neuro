//
//  MLineDataPacket.m
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "MLineDataPacket.h"

@implementation MLineDataPacket


- (void)addOneValueByX:(NSNumber *)x andY:(NSNumber *)y{
    if (_chartDataArray) {
        _chartDataArray = @[].mutableCopy;
    }
    
    [_chartDataArray addObject:[[ChartDataEntry alloc] initWithX:x.doubleValue y:y.doubleValue]];
    
    NSMutableArray *values = _chartDataSet.values.mutableCopy;
    
    [values addObject:[[ChartDataEntry alloc] initWithX:x.doubleValue y:y.doubleValue]];
    
    if ([values count] > _showingDataLimit) {
        [values removeObjectsInRange:NSMakeRange(0, 1)];
    }
    
    _chartDataSet.values = values.copy;
}

- (void)LineChartDataSetAddAttributes:(LineChartDataSet *)set1{
    
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:UIColor.blackColor.randomColor];
    [set1 setCircleColor:UIColor.whiteColor];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.fillAlpha = 65/255.0;
    set1.fillColor = UIColor.blackColor.randomColor;
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set1.drawCircleHoleEnabled = NO;
    
}

- (MLineDataPacket *)initWithTitle:(NSString *)title{
    self = [super init];
    
    if (self) {
        
        _showingDataLimit = 20; // it could be related with orientation;
        ChartDataEntry *firstEntry = [[ChartDataEntry alloc] initWithX:0 y:0];
        _chartDataSet = [[LineChartDataSet alloc] initWithValues:@[firstEntry] label:title];
        [self LineChartDataSetAddAttributes:_chartDataSet];
        
        
    }
    
    return self;
}
@end
