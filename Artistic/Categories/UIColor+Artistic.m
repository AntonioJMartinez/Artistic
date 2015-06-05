//
//  UIColor+Artistic.m
//  Artistic
//
//  Created by Antonio J. on 29/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "UIColor+Artistic.h"

@implementation UIColor (Artistic)

+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alphaValue {
    unsigned int hexint = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alphaValue];
    
    return color;
}

+ (UIColor*)navigationBarColor {
    return [UIColor colorWithHexString:@"121C2F" andAlpha:1.0];
}

+ (UIColor*)backgroundColor {
    return [UIColor colorWithHexString:@"121C2F" andAlpha:1.0];
}

@end
