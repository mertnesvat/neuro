//
//  MMultipleLinesDataPacket.h
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLineDataPacket.h"

@interface MMultipleLinesDataPacket : BaseModel
@property IXNMuseDataPacket *packetMuse;
@property NSMutableArray *packetArray;
@property NSArray *lineChartDataSetArray;
@property NSMutableArray<MLineDataPacket *> *arrayMLineDataPacket;
@property NSString *title;
@property LineChartData *data;

- (MMultipleLinesDataPacket *)initWithIXNMuseDataPacketWithName:(NSString *)title;
- (MMultipleLinesDataPacket *)addIXNMuseDataPacketToTheLines : (IXNMuseDataPacket *)packet;

@end
