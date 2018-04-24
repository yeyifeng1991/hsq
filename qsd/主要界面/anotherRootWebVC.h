//
//  anotherRootWebVC.h
//  qsd
//
//  Created by mc on 2018/4/24.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
#import "AppStartConfigModel.h"
typedef enum enterStatus1{
    enterSysConfig1, //   系统配置
    enterAppStarted1//   启动页配置
    
}enterStatus1;
@interface anotherRootWebVC : UIViewController
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, assign)BOOL isOpenHud;
@property (nonatomic, strong)UIButton *btnBack;
@property (nonatomic,strong) MBProgressHUD * hud;
@property (nonatomic,assign)  BOOL isFirst;
@property (nonatomic,assign) enterStatus1 status ;// 外部页面的进入状态

/**
 void
 @param url 网址
 */
- (void)createWebViewWithURL:(NSString *)url;

@property (nonatomic,strong) AppStartConfigModel * systemModel;
@property (nonatomic,strong) AppStartConfigModel * startModel;
@property (nonatomic,strong) AppStartConfigModel * colorModel;
@end



