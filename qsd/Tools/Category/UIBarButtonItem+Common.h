//
//  UIBarButtonItem+Common.h
//  QiMu
//
//  Created by YeYiFeng on 16/12/21.
//  Copyright © 2016年 XH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Common)
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title image:(UIImage *)image target:(id)obj action:(SEL)selector;
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector;
+ (UIBarButtonItem *)itemWithBtnTitle:(NSInteger )title Iconimage:(UIImage *)image target:(id)obj action:(SEL)selector;//自定义导航栏带有角图标的按钮
+ (UIBarButtonItem *)itemWithBtnImage:(UIImage *)image target:(id)obj action:(SEL)selector;
//返回图片上方有红点的图标
+ (UIBarButtonItem *)itemWithBtnImage:(UIImage *)image withTipView:(BOOL)hidden  target:(id)obj action:(SEL)selector;
@end
