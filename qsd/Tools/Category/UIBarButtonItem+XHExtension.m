//
//  UIBarButtonItem+XHExtension.m
//  b2b
//
//  Created by XH on 16/8/14.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "UIBarButtonItem+XHExtension.h"

@implementation UIBarButtonItem (XHExtension)

+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
                                         target:(id)target
                                         action:(SEL)action{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    button.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, 10);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}
+ (instancetype)barButtonLeftItemWithName:(NSString *)str
                                   target:(id)target
                                   action:(SEL)action
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 22)];
    [button setTitle:str forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:17];
//    [button setTitleColor:XHColor(0x333333) forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}
//导航栏为纯文字的按钮
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:obj action:selector];
//    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: XHColor(0x0378ff),NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
//    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: XHColor(0x0378ff),NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateDisabled];
    return buttonItem;
}
@end
