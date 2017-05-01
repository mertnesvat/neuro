//
//  BaseVC.h
//  neuro
//
//  Created by Mert Neşvat on 01/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <Muse/Muse.h>
#import <Charts/Charts.h>
#import "Singleton.h"

@interface BaseVC : UIViewController
@property IXNMuseManagerIos * manager;
@property (weak, nonatomic) IXNMuse * muse;

@end
