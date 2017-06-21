//
//  GraphCell.h
//  neuro
//
//  Created by Mert Neşvat on 21/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

@interface GraphCell : UITableViewCell
@property (weak, nonatomic) IBOutlet LineChartView *chartView;

@end
