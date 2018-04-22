//
//  UIDevice+XHExtension.m
//  b2b
//
//  Created by XH on 16/8/15.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "UIDevice+XHExtension.h"
#import "common.h"

@implementation UIDevice (XHExtension)

+ (CGFloat) currentDeviceScreenMeasurement{
    
    CGFloat deviceScreen;
    
    if ((568 == SCREEN_HEIGHT && 320 == SCREEN_WIDTH) || (1136 == SCREEN_HEIGHT && 640 == SCREEN_WIDTH)) {
        deviceScreen = 4.0;
    } else if ((667 == SCREEN_HEIGHT && 375 == SCREEN_WIDTH) || (1334 == SCREEN_HEIGHT && 750 == SCREEN_WIDTH)) {
        deviceScreen = 4.7;
    } else if ((736 == SCREEN_HEIGHT && 414 == SCREEN_WIDTH) || (2208 == SCREEN_HEIGHT && 1242 == SCREEN_WIDTH)) {
        deviceScreen = 5.5;
    }
    
    return deviceScreen;
}
+ (CGFloat) systemDevice{
    CGFloat systemDevice;
    systemDevice = [[[UIDevice currentDevice] systemVersion] floatValue];
    return systemDevice;
}

@end
