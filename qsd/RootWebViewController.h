//
//  RootWebViewController.h
//  qsd
//
//  Created by mc on 2018/4/22.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
@interface RootWebViewController : UIViewController
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, assign)BOOL isOpenHud;
@property (nonatomic, strong)UIButton *btnBack;
@property (nonatomic,strong) MBProgressHUD * hud;

/**
 void
 @param url 网址
 */
- (void)createWebViewWithURL:(NSString *)url;

@end
