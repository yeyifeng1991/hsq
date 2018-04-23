//
//  RootWebViewController.m
//  qsd
//
//  Created by mc on 2018/4/22.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "RootWebViewController.h"
#import "Masonry.h"
#import "common.h"

@interface RootWebViewController ()<WKUIDelegate, WKNavigationDelegate>
@property(nonatomic,strong) UIBarButtonItem *backItem;

@property (nonatomic,strong) UILabel * titleLab;

@end
#define CCXSIZE [UIScreen mainScreen].bounds.size//获取屏幕SIZE
#define GJJBlackTextColorString @"3b3a3e"

#define CCXSCREENSCALE CCXSIZE.width/750.0f //获取当前屏幕尺寸与苹果6S宽度比

@implementation RootWebViewController

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
}
//根据颜色生成图片
-(UIImage *)createImageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = CCXColorWithHex(@"#ffffff");
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.clipsToBounds = NO;
    [self setBackNavigationBarItem];
//    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.navigationItem.title = @"搞事情";
    [self createWebViewWithURL:self.url];
    
////    self.btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 12, 20)];
//        self.btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
//    [self.btnBack setImage:[UIImage imageNamed:@"back"] forState: UIControlStateNormal];
//    self.btnBack.backgroundColor = [UIColor redColor];
//    [self.btnBack addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnBack];
//    self.navigationItem.leftBarButtonItem = buttonItem;
//    [self setBackNavigationBarItem];
}
#pragma mark - 自定义方法
/**
 *   使导航栏透明
 */
- (void)setClearNavigationBar{
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

/**
 创建返回按钮
 */
- (void)setBackNavigationBarItem{
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    baseView.backgroundColor = [UIColor grayColor];

//
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 14, 200, 30)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor whiteColor];
    [baseView addSubview:self.titleLab];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    imageV.frame = CGRectMake(12, 20, 12, 20);
//    imageV.backgroundColor = [UIColor greenColor];
    imageV.userInteractionEnabled = YES;
    [baseView addSubview:imageV];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 64, 44);
    button.tag = 9999;
    [button addTarget:self action:@selector(BarbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:button];
    [self.view addSubview:baseView];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
//    self.navigationItem.leftBarButtonItem = item;
//    UIView *ringhtV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:ringhtV];
//    self.navigationItem.rightBarButtonItem = rightItem;
}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
-(void)BarbuttonClick:(UIButton*)button
{
    if (_webView.backForwardList.backList.count > 0){
        [self.webView goBack];
    } else {
        if (self.isFirst == YES) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRootViewController" object:@"fromAdVC"];

        }
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)createWebViewWithURL:(NSString *)url{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    [self.view addSubview:self.progressView];
//    [self.progressView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//        make.height.equalTo(@(2 * CCXSCREENSCALE));
//    }];
//    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.top.left.right.equalTo(self.view);
//        make.height.equalTo(@(2 * CCXSCREENSCALE));
//    }];
   
    
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
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-64) configuration:config];
    [self.webView.configuration.userContentController addUserScript:noneSelectScript];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
//    [self.webView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.progressView.bottom);
//        make.left.right.bottom.equalTo(self.view);
//    }];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.progressView.mas_bottom);
//        make.left.right.bottom.equalTo(self.view);
//    }];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

//观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
   
    if ([keyPath isEqualToString:@"estimatedProgress"]&&object == _webView) {
        if (!self.isOpenHud){
//            self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
    }
    else if([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView) {
            self.titleLab.text = self.webView.title;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    
    else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)onBack {
    
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
