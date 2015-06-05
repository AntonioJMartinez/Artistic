//
//  UIColor+Artistic.h
//  Artistic
//
//  Created by Antonio J. on 29/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Artistic)


+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alphaValue;

+ (UIColor*)navigationBarColor;

+ (UIColor*)backgroundColor;

@end
