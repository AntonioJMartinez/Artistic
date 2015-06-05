//
//  UIFont+Artistic.m
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "UIFont+Artistic.h"

@implementation UIFont (Artistic)

+ (UIFont*)quicksandRegularOfSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"Quicksand-Regular" size:size];
    return font;
}
+ (UIFont*)quicksandBoldOfSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"Quicksand-Bold" size:size];
    return font;
}
+ (UIFont*)quicksandLightOfSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"Quicksand-Light" size:size];
    return font;
}

@end
