//
//  RootWebViewController.m
//  qsd
//
//  Created by mc on 2018/4/22.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "RootWebViewController.h"
#import "Masonry.h"


@interface RootWebViewController ()<WKUIDelegate, WKNavigationDelegate>


@end
#define CCXSIZE [UIScreen mainScreen].bounds.size//获取屏幕SIZE

#define CCXSCREENSCALE CCXSIZE.width/750.0f //获取当前屏幕尺寸与苹果6S宽度比

@implementation RootWebViewController

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = CCXColorWithHex(@"#ffffff");
    self.view.backgroundColor = [UIColor whiteColor];
    [self createWebViewWithURL:self.url];
    
    self.btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 12, 20)];
    [self.btnBack setImage:[UIImage imageNamed:@"箭头"] forState: UIControlStateNormal];
    [self.btnBack addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnBack];
    self.navigationItem.leftBarButtonItem = buttonItem;
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

- (void)createWebViewWithURL:(NSString *)url{
    self.progressView = [[UIProgressView alloc] init];
    [self.view addSubview:self.progressView];
//    [self.progressView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//        make.height.equalTo(@(2 * CCXSCREENSCALE));
//    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(2 * CCXSCREENSCALE));
    }];
   
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
    
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    /**网页*/
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    [self.webView.configuration.userContentController addUserScript:noneSelectScript];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
//    [self.webView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.progressView.bottom);
//        make.left.right.bottom.equalTo(self.view);
//    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

//观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]&&object == _webView) {
        if (!self.isOpenHud){
            self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            self.hud.detailsLabel.text = @"加载中...";
            self.isOpenHud = true;
        }
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:_webView.estimatedProgress animated:YES];
        if (_webView.estimatedProgress == 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.equalTo(self.view);
                    make.height.equalTo(@(0));
                }];
                [self.progressView setProgress:0.0f animated:NO];
                [self.hud hideAnimated:YES];
                self.isOpenHud = false;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)onBack {
    if (_webView.backForwardList.backList.count > 0){
        [self.webView goBack];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)banGesture{
    for (UIView *scrollView in self.webView.subviews) {
        if ([scrollView isKindOfClass:NSClassFromString(@"WKScrollView")]) {
            for (UIView *contentView in scrollView.subviews) {
                if ([contentView isKindOfClass:NSClassFromString(@"WKContentView")]) {
                    NSMutableArray *gestureRecognizers = [NSMutableArray arrayWithArray:contentView.gestureRecognizers];
                    NSMutableArray *deleteTapArray = [NSMutableArray arrayWithCapacity:0];
                    for (UIGestureRecognizer *tap in gestureRecognizers) {
                        if ([tap isKindOfClass:[UILongPressGestureRecognizer class]]) {
                            [deleteTapArray addObject:tap];
                        }
                    }
                    [gestureRecognizers removeObjectsInArray:deleteTapArray];
                    contentView.gestureRecognizers = gestureRecognizers;
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
