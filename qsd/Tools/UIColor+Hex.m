//
//  UIColor+Hex.m
//  RenRenhua2.0
//
//  Created by 陈传熙 on 16/10/20.
//  Copyright © 2016年 chenchuanxi. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rSting = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rSting] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color{
    return [UIColor colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity{
    float red = ((float)((hexColor & 0xFF0000) >> 16)) / 255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8)) / 255.0;
    float blue = ((float)(hexColor & 0xFF)) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
