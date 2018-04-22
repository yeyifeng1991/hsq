//
//  UIViewController+XHLogin.m
//  b2b
//
//  Created by XH on 16/9/29.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "UIViewController+XHLogin.h"
#import "XHNavigationController.h"

@implementation UIViewController (XHLogin)

- (void)notificationCenter{
    //登陆
    //在http requst中发出，根据每次请求网络数据时提供的token来判断
    [XHNotificationCenter addObserver:self selector:@selector(buildLoginView) name:LoginViewAppear object:nil];
    //登陆完成
    //在login中登陆成功时发出，完成后销毁login视图
    [XHNotificationCenter addObserver:self selector:@selector(killLoginView) name:LoginViewDisAppear object:nil];
}

- (void)buildLoginView{
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:@"重新登录" message:@"账户登录超时或已在其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *boyAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *girlAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *login = [[LoginViewController alloc] init];
        XHNavigationController *na = [[XHNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:na animated:YES completion:nil];
    }];
    [alertDialog addAction:boyAction];
    [alertDialog addAction:girlAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
}
- (void)killLoginView{
    
}

@end
