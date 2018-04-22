//
//  UIBarButtonItem+XHExtension.h
//  b2b
//
//  Created by XH on 16/8/14.
//  Copyright © 2016年 XH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XHExtension)

+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action;
+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
                                         target:(id)target
                                         action:(SEL)action;

+ (instancetype)barButtonLeftItemWithName:(NSString *)str
                                        target:(id)target
                                        action:(SEL)action;
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector;//自定义名称的导航栏按钮
@end
