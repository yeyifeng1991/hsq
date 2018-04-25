//
//  XHWebVC.m
//  QiMu
//
//  Created by XH on 16/12/20.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "XHWebVC.h"
#import <WebKit/WebKit.h>
#import "common.h"
#import "SVProgressHUD+XH.h"
@interface XHWebVC ()<WKNavigationDelegate>

@property (assign, nonatomic) NSUInteger loadCount;
@property (nonatomic, weak) WKWebView *wkView;
@property (nonatomic, strong) UIProgressView *progressView;

@end
#define WebViewNav_TintColor ([UIColor orangeColor])
@implementation XHWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"金讯达";
    [self.view addSubview:self.wkView]; // 先添加再载入
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_apPicUrl]];
    [self.wkView loadRequest:request];
    
}

- (void)setApPicUrl:(NSString *)apPicUrl
{
    _apPicUrl = apPicUrl;

}
- (void)setNameDic:(NSDictionary *)nameDic
{
    self.navigationItem.title = [nameDic allKeys].lastObject ;
    NSURL *fileUrl = [NSURL URLWithString:[nameDic allValues].firstObject];
     [self.wkView loadRequest:[NSMutableURLRequest requestWithURL:fileUrl]];

}

- (WKWebView *)wkView{
    if (!_wkView) {
        // 进度条
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        progressView.tintColor = WebViewNav_TintColor;
        progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:progressView];
        self.progressView = progressView;
        // 网页
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        wkWebView.backgroundColor = [UIColor whiteColor];
        wkWebView.navigationDelegate = self;
        [self.view insertSubview:wkWebView belowSubview:progressView];
        self.wkView = wkWebView;
        [self.wkView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _wkView;
}


// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1)
        {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}


// 记得取消监听
- (void)dealloc {
    @try {
        NSLog(@"------移除观察者----");
        [self.wkView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
        [self.wkView setNavigationDelegate:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"WKWebview中手动拿到的错误Exception: %@", exception);
    }
    @finally  {
        // Added to show finally works as well
    }
    
}

- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
        
    }
}

#pragma mark - WKwebViewDelegate
/// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.loadCount ++;
}
/// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    self.loadCount --;
}
/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

}
/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.loadCount --;
    
}
- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    self.loadCount --;
    [self.navigationController popViewControllerAnimated:YES];
    [SVProgressHUD showErrorWithStatus:@"加载失败" duration:1.0];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
