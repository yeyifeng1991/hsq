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
#import "anotherRootWebVC.h"
#import "SVProgressHUD+XH.h"
#import "UIColor+Hex.h"
@interface RootWebViewController ()<WKUIDelegate, WKNavigationDelegate>
@property(nonatomic,strong) UIBarButtonItem *backItem;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,assign) NSInteger page; // WkWebview方法拦截可返回次数不准,增加此参数用来记录判断
@property (nonatomic,strong) UIButton * homeBtn; /// 首页刷新按钮

@end
#define CCXSIZE [UIScreen mainScreen].bounds.size//获取屏幕SIZE
#define GJJBlackTextColorString @"3b3a3e"

#define CCXSCREENSCALE CCXSIZE.width/750.0f //获取当前屏幕尺寸与苹果6S宽度比

@implementation RootWebViewController

- (void)dealloc{
    @try {
 
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:@"Progress"];
        [self.webView removeObserver:self forKeyPath:@"title" context:@"title1"];
        [self.webView setNavigationDelegate:nil];
        [self.webView setUIDelegate:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"WKWebview中手动拿到的错误Exception: %@", exception);
    }
    @finally  {
        // Added to show finally works as well
    }
  
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = -1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.clipsToBounds = NO;
//    [self setClearNavigationBar];
    [self setBackNavigationBarItem];
    // http://jxd.wedaiclub.cn/
    [self createWebViewWithURL:@"http://jxd.wedaiclub.cn/"];
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
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT)];

    NSString * str = [XHDefault objectForKey:@"color"];
    if (str) {
        baseView.backgroundColor = [UIColor colorWithHexString:str];

    }
    else
    {
        baseView.backgroundColor = [UIColor orangeColor];

    }
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 30, 200, 25)];
    self.titleLab.font = [UIFont systemFontOfSize:18];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor whiteColor];
    [baseView addSubview:self.titleLab];
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bigBack"]];
    imageV.frame = CGRectMake(12, 30, 13.5, 25);
    imageV.userInteractionEnabled = YES;
    imageV.contentMode = UIViewContentModeScaleToFill;
    [baseView addSubview:imageV];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 84, NAVIGATION_HEIGHT);
    self.backBtn.tag = 9999;
//    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [ self.backBtn addTarget:self action:@selector(BarbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * backLab = [[UILabel alloc]initWithFrame:CGRectMake(36, 29, 40, 25)];
    backLab.textColor = [UIColor whiteColor];
    backLab.text = @"返回";
    backLab.font = [UIFont systemFontOfSize:18];
    [self.backBtn addSubview:backLab];
    [self.backBtn addSubview:imageV];
    [baseView addSubview: self.backBtn];

    // 导航栏的关闭按钮
   self.homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-52, 30, 40 ,25)];
    self.homeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.homeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    [self.homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.homeBtn addTarget:self action:@selector(HomePressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.homeBtn sizeToFit];
    [baseView addSubview:self.homeBtn];
    
    if (self.status ==  enterSysConfig) { // 不可返回界面
        if (self.page>0) {
            self.homeBtn.hidden = NO; // 出现刷新首页界面
        }
        else
        {
            self.homeBtn.hidden = YES; // 隐藏刷新界面
        }
        self.backBtn.hidden = YES;
    }else // 返回界面
    {
        self.backBtn.hidden = NO;
        self.homeBtn.hidden= YES; // home界面需要隐藏
    }
    [self.view addSubview:baseView];    

}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#pragma mark - 返回按钮事件
-(void)BarbuttonClick:(UIButton*)button
{
    NSLog(@"----- 按钮方法执行 ---");
    if (self.webView.backForwardList.backList.count > 0){
        [self.webView goBack];
    } else {
        if (self.status == enterSysConfig) // 从第一种方式进入,不可以返回
        {
            return;
        }
        else
        {
            if ([self.systemModel.value isEqualToString:@"True"]) { // 需要进入web界面
                anotherRootWebVC * webVc = [[anotherRootWebVC alloc]init];
                webVc.status = enterSysConfig;
                webVc.systemModel = self.systemModel;
                webVc.url = self.systemModel.url;
                webVc.colorModel = self.colorModel;
                webVc.hidesBottomBarWhenPushed = YES;
                webVc.isFirst = NO;
                [self.navigationController pushViewController:webVc animated:YES];
            }
            else // 进入home界面
            {
                if (self.isFirst) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRootViewController" object:@"fromAdVC"];

                }
//                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
     
    }
}
#pragma mark - 首页刷新按钮
-(void)HomePressed
{
        if ( self.page >0) {         //得到栈里面的list
//            [self createWebViewWithURL:self.url];
            self.page = -1;// 记录参数修改为-1
            [self deleteWebCache];
            NSLog(@"webView的加载记录个数 = %ld",self.webView.backForwardList.backList.count);
            if (self.webView.backForwardList.backList.count >0) {
                [self.webView goToBackForwardListItem:self.webView.backForwardList.backList.firstObject]; // 返回到第一个元素
                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]]; // 重新加载指定webView
            }
            else
            {
                [SVProgressHUD showWithStatus:@"已在当前页面" duration:2];
            }
        }
}
- (void)createWebViewWithURL:(NSString *)url{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0)];
    self.progressView.tintColor =  [self colorWithHexString:self.colorModel.value];
//    self.progressView.trackTintColor = [UIColor clearColor];
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
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) configuration:config];
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
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"Progress"];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"title1"];
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
            if (self.webView.title.length>7) {
                self.titleLab.text = [self.webView.title substringToIndex:7];//截取下标7之前的字符串

            }
            self.titleLab.text = self.webView.title;
            
        }
        
    }
    
   
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//       self.page ++;
//    NSLog(@"进行加加的操作%ld",self.page);
    if ( navigationAction.navigationType== WKNavigationTypeBackForward) {
        self.page --; // 返回操作
        NSLog(@"返回操作 %ld",self.page);
    }
    else
    {
        self.page ++; // 加载操作
        NSLog(@"加载操作 %ld",self.page);
    }
    NSLog(@"代理返回的历史记录 = %ld",webView.backForwardList.backList.count);
        if (webView.backForwardList.backList.count > 0){
            self.backBtn.hidden = NO;
            self.homeBtn.hidden = NO;
        }
        else
        {
            if (self.status == enterSysConfig) {
                if (self.page >0) {
                    self.backBtn.hidden = NO;
                    self.homeBtn.hidden = NO;
                }
                else
                {
                    self.homeBtn.hidden = YES;
                    self.backBtn.hidden = YES;
                }
            }
            else{
                if (self.page >0) {
                    self.backBtn.hidden = NO;
                    self.homeBtn.hidden = NO;
                }
                else
                {
                    self.homeBtn.hidden = YES;
                    self.backBtn.hidden = NO;
                }
            }
          
        }

    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - 清除缓存
- (void)deleteWebCache {
    
    if([[UIDevice currentDevice].systemVersion floatValue] >=9.0) {
        
        NSSet*websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        NSDate*dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
        }];
        
    }else{
        
        NSString*libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)objectAtIndex:0];
        
        NSString*cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        
        NSError*errors;
        
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
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
