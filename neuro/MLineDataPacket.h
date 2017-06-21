//
//  MLineDataPacket.h
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MChartDataPacket.h"

@interface MLineDataPacket : BaseModel
@property NSMutableArray<ChartDataEntry *> *chartDataArray;
@property LineChartDataSet *chartDataSet;
@property int showingDataLimit; 

- (void)addOneValueByX:(NSNumber *)x andY:(NSNumber *)y;
- (MLineDataPacket *)initWithTitle:(NSString *)title;



@end
