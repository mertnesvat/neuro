//
//  MChartDataPacket.h
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Muse/Muse.h>
#import "BaseModel.h"
@import Charts;

// Composition Model which includes both muse packet and chart packet

@interface MChartDataPacket : BaseModel

@property IXNMuseDataPacket *packetMuse;
@property NSArray *packetChartArray; // this is only one fragment x , y coordiante for all values

- (MChartDataPacket *)initWithIXNMuseDataPacket:(IXNMuseDataPacket *)packet;
@end
