//
//  UIColor+Hex.h
//  RenRenhua2.0
//
//  Created by 陈传熙 on 16/10/20.
//  Copyright © 2016年 chenchuanxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
