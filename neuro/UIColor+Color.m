//
//  UIColor+Color.m
//  neuro
//
//  Created by Mert Neşvat on 20/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)
- (UIColor *)randomColor{
    double randomVal1 = (double) (arc4random_uniform(200)) + 50;
    double randomVal2 = (double) (arc4random_uniform(200)) + 50;
    double randomVal3 = (double) (arc4random_uniform(200)) + 50;
    UIColor *color = [UIColor colorWithRed:randomVal1/255.f green:randomVal2/255.f blue:randomVal3/255.f alpha:1.f];
    
    return color;
}
@end
