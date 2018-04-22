//
//  SVProgressHUD+XH.h
//  QiMu
//
//  Created by XH on 17/2/21.
//  Copyright © 2017年 XH. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (XH)

+ (void)hudConfiguration;

+ (void)showWithStatus:(NSString *)status duration:(NSTimeInterval)interval;
+ (void)showInfoWithStatus:(NSString*)status duration:(NSTimeInterval)interval;
+ (void)showErrorWithStatus:(NSString*)status duration:(NSTimeInterval)interval;
+ (void)showSuccessWithStatus:(NSString*)status duration:(NSTimeInterval)interval;

+ (void)showWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showProgress:(float)progress andStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showInfoWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showErrorWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showSuccessWithStatus:(NSString*)status andMaskType:(SVProgressHUDMaskType)maskType;

@end
