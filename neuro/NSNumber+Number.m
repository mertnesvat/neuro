//
//  NSNumber+Number.m
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "NSNumber+Number.h"

@implementation NSNumber (Number)
- (NSNumber *)randomNumber{
    return [[NSNumber alloc]initWithInt:(random() % 10)];
}
@end
