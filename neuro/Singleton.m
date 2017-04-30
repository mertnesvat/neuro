//
//  Singleton.m
//  
//
//  Created by Mert Neşvat on 01/05/2017.
//
//

#import "Singleton.h"


@implementation Singleton


#pragma mark Singleton Methods

+ (Singleton *)shared {
    static Singleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
