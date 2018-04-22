//
//  SVProgressHUD+XH.m
//  QiMu
//
//  Created by XH on 17/2/21.
//  Copyright © 2017年 XH. All rights reserved.
//

#import "SVProgressHUD+XH.h"

@implementation SVProgressHUD (XH)

+ (void)hudConfiguration
{
    [self setBackgroundColor:[UIColor colorWithRed:250 green:251 blue:252 alpha:1]];
    [self setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
}

+ (void)showWithStatus:(NSString *)status duration:(NSTimeInterval)interval
{
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self showWithStatus:status];
    [self dismissWithDelay:interval];
}
+ (void)showInfoWithStatus:(NSString*)status duration:(NSTimeInterval)interval
{
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showInfoWithStatus:status];
    [self dismissWithDelay:interval];
}
+ (void)showErrorWithStatus:(NSString*)status duration:(NSTimeInterval)interval
{
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self showErrorWithStatus:status];
    [self dismissWithDelay:interval];
}
+ (void)showSuccessWithStatus:(NSString*)status duration:(NSTimeInterval)interval
{
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self showSuccessWithStatus:status];
    [self dismissWithDelay:interval];
}



+ (void)showWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType
{
    [self setDefaultMaskType:maskType];
    [self showWithStatus:status];
}
+ (void)showProgress:(float)progress andStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType
{
    [self setDefaultMaskType:maskType];
    [self showProgress:progress status:status];
}
+ (void)showInfoWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType
{
    [self setDefaultMaskType:maskType];
    [self showWithStatus:status duration:1.0];
}
+ (void)showErrorWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType
{
    [self setDefaultMaskType:maskType];
    [self showErrorWithStatus:status duration:1.0];
}
+ (void)showSuccessWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType
{
    [self setDefaultMaskType:maskType];
    [self showSuccessWithStatus:status duration:1.0];
}
@end
