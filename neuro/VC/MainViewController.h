//
//  MainViewController.h
//  neuro
//
//  Created by Mert Neşvat on 30/04/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Muse/Muse.h>

@interface MainViewController : UIViewController < IXNMuseConnectionListener, IXNMuseDataListener, IXNMuseListener, IXNLogListener>

@property (nonatomic, strong) IBOutlet UITextView* logView;


@end
