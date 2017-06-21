//
//  ObserveViewController.h
//  neuro
//
//  Created by Mert Neşvat on 01/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "GraphCell.h"

@interface ObserveViewController : BaseVC <UITableViewDelegate, UITableViewDataSource, IXNMuseConnectionListener, IXNMuseDataListener, IXNMuseListener, IXNLogListener>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *selectedOptions;
@property (nonatomic, strong) NSMutableDictionary *optionsDataset;
@property (nonatomic, strong) NSString *selectedDataSet;
@property (nonatomic, strong) NSArray<MMultipleLinesDataPacket *> *lines;
@property (nonatomic, strong) MMultipleLinesDataPacket *multi;


@property (nonnull, strong) NSMutableArray *testArrayOfDataPacket;



@end
