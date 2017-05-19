//
//  ObserveViewController.h
//  neuro
//
//  Created by Mert Neşvat on 01/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface ObserveViewController : BaseVC <IXNMuseConnectionListener, IXNMuseDataListener, IXNMuseListener, IXNLogListener>

@property (nonatomic, strong) NSDictionary *selectedOptions;
@property (nonatomic, strong) NSMutableDictionary *optionsDataset;
@property (nonatomic, strong) NSString *selectedDataSet;

@end
