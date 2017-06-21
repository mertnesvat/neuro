//
//  MChartDataPacket.m
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "MChartDataPacket.h"

@implementation MChartDataPacket

-(MChartDataPacket *)initWithIXNMuseDataPacket:(IXNMuseDataPacket *)packet{
    self = [super init];
    
    if (self) {
        _packetMuse = packet;
        NSMutableArray *valuesArray = @[].mutableCopy;
        for (NSNumber * val in packet.values) {
            double v = [val doubleValue];
            
            [valuesArray addObject:[[ChartDataEntry alloc] initWithX:packet.timestamp y:v]];
        }
        _packetChartArray = valuesArray.copy;
    }
    
    return self;
}

@end
