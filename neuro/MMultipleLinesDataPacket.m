//
//  MMultipleLinesDataPacket.m
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "MMultipleLinesDataPacket.h"

@implementation MMultipleLinesDataPacket
static int timeRelative = 0;

- (MMultipleLinesDataPacket *)initWithIXNMuseDataPacketWithName:(NSString *)title{
    self = [super init];
    
    if (self) {
        
        _packetArray = @[].mutableCopy;
        
        _lineChartDataSetArray = @[];
        _arrayMLineDataPacket = @[].mutableCopy;
        _title = title;
        // _lineChartDataSetArray = @[]; // other models will create line charts
    }
    
    return self;
}

-(MMultipleLinesDataPacket *)addIXNMuseDataPacketToTheLines:(IXNMuseDataPacket *)packet{

    [_packetArray addObject:packet];
    //update the subclasses
    //update chart data
    
    
    timeRelative++;
    for (int a = 0; a < [packet.values count]; a++) {
        if ([_arrayMLineDataPacket count] < [packet.values count]) {
            
            NSString *compositeTitle = [NSString stringWithFormat:@"%@ - %d",_title,a];
            
            [_arrayMLineDataPacket addObject:[[MLineDataPacket alloc] initWithTitle:compositeTitle]];
        }
        
        NSNumber *time = [NSNumber numberWithInt:timeRelative];
        
        [_arrayMLineDataPacket[a] addOneValueByX:time andY:packet.values[a]];
        
    }
    

    if (!_data) {
        _data = [[LineChartData alloc] initWithDataSets:[self getAllChartDataSetsFromMLineArrays]];
    }
    
    _data.dataSets = [self getAllChartDataSetsFromMLineArrays];
    
    
    return self;
}

- (NSArray *)getAllChartDataSetsFromMLineArrays{
    NSMutableArray *arr = @[].mutableCopy;
    for (MLineDataPacket *line in _arrayMLineDataPacket) {
        [arr addObject:line.chartDataSet];
    }
    
    return arr.copy;
}


@end
