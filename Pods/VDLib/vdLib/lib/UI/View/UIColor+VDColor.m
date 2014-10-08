//
//  UIColor+BS.m
//
//  Created by  on 12-1-5.
//  Copyright (c) 2012年  All rights reserved.
//

#import "UIColor+VDColor.h"

@implementation UIColor (VDColor)

+ (UIColor*)colorWithARGB:(NSUInteger)argb
{
    CGFloat alpha = (argb > 0xFFFFFF) ? (((argb>>24)&0xFF)/255.0f) : 1.0f;
    return [UIColor colorWithRGB:argb alpha:alpha];
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb;
{
    return [UIColor colorWithRGB:rgb alpha:1.0f];
}

+ (UIColor*)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha
{
    NSUInteger red = (rgb>>16)&0xFF;
    NSUInteger green = (rgb>>8)&0xFF;
    NSUInteger blue = rgb&0xFF;
    return RGBA(red, green, blue, alpha);
}

@end
