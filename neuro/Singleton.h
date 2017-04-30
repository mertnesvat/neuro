//
//  Singleton.h
//  
//
//  Created by Mert Neşvat on 01/05/2017.
//
//

#import <Foundation/Foundation.h>
#import <Muse/Muse.h>

@interface Singleton : NSObject{
    
}
@property IXNMuseManagerIos * manager;
@property (weak, nonatomic) IXNMuse * muse;

+ (Singleton *)shared;

@end
