//
//  AdViewController.m
//  xiaoqianfeng
//
//  Created by mc on 2017/10/20.
//  Copyright © 2017年 jiucangtouzi. All rights reserved.
//

#import "AdViewController.h"
#import "AFNetworking.h"
#import "common.h"
#import "Masonry.h"
#import "NetworkManager.h"
#import "AppStartConfigModel.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "RootWebViewController.h"
#import "UIImageView+WebCache.h"

@interface AdViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong)NSTimer *countDownTimer;
@property (nonatomic,strong) AppStartConfigModel * sysmodel ;// 系统配置数据类
@property (nonatomic,strong) AppStartConfigModel * startmodel ;// 启动页配置数据类
@property (nonatomic,strong) AppStartConfigModel * colorModel; // 颜色配置数据类


@end
#define CCXPROTOCOL @"http://hsq.xyd.jiucangjinrong.com/xiaoyuedai/zcxy2.html" //快速注册协议

@implementation AdViewController
{
    UIButton *_closeBtn;
    UIImageView *_backgroundImageView;
    NSInteger _secondCountDown;
}

- (void)dealloc{
    NSLog(@"没有内存泄漏");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self startAppConfig];
    [self createSubviews]; // 页面布局
    [self networkDetectionAndSetting]; // 检查网络状态
    NSLog(@"状态栏高度==%f导航栏高度==%f",STATUSBAR_HEIGHT,NAVIGATION_HEIGHT);

}

//网络检测与设置
- (void)networkDetectionAndSetting{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
                NSLog(@"GPRS网络");
                break;
            case 2:
                NSLog(@"wifi网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"isConnected" object:nil];
                break;
            default:
                break;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"有网");
        }else{
            NSLog(@"没有网");
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationControl.navigationBarHidden=NO;
    self.navigationController.navigationBarHidden = YES;

}
- (void)createSubviews{
    //背景图，临时设置为开机动画，后面要更改为网络请求的图片
//    _backgroundImageView = KBACKGROUNDVIEW(@"AppBoot");
    _backgroundImageView = [[UIImageView alloc]init];
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [_backgroundImageView addGestureRecognizer:tapGesture1];
    [self.view addSubview:_backgroundImageView];
    _backgroundImageView.frame = self.view.bounds;
//    _backgroundImageView.frame = CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT);
    _backgroundImageView.userInteractionEnabled = YES;
    
    
    //倒计时按钮
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundImageView addSubview:_closeBtn];
    [_closeBtn setTitle:@"5s" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:RGBHex(0x3b3a3e) forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptationWidth(14)];
    [_closeBtn addTarget:self action:@selector(timerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.backgroundColor = [RGBHex(0xFFCCCCCC) colorWithAlphaComponent:0.5];
    _closeBtn.layer.cornerRadius = AdaptationHeight(25) / 2.0;
    _closeBtn.layer.masksToBounds = YES;
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundImageView.mas_top).offset(STATUSBAR_HEIGHT);
        make.right.equalTo(_backgroundImageView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(AdaptationWidth(60), AdaptationHeight(25)));
    }];
    
    //定时器设置
    _secondCountDown = 5;
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}
#pragma mark - 点击图片方法 启动图片逻辑  需要返回
- (void)tapGesture:(id )sender
{

    // 点击图片
    
     if (self.startmodel.url!=nil && ![self.startmodel.url isEqualToString:@"#"]) {
           [self killNSTimer];
     // 跳转webView
     RootWebViewController * webVc = [[RootWebViewController alloc]init];
     webVc.status = enterAppStarted;// 启动页状态
     webVc.systemModel = self.sysmodel;
         webVc.startModel = self.startmodel;
     webVc.url = self.startmodel.url;
     webVc.colorModel = self.colorModel;
     webVc.isFirst = YES;
     [self.navigationController pushViewController:webVc animated:YES];
    }

    
}
//定时器执行方法
#pragma mark - 定时器的方法
- (void)countDownAction{
    _secondCountDown --;
    [_closeBtn setTitle:[NSString stringWithFormat:@"%@s",@(_secondCountDown)] forState:UIControlStateNormal];
    if (_secondCountDown == 0) {
//        [self killNSTimer];
        [self sysConfigRootWebviewController];
    }
}
#pragma mark - 倒计时按钮的绑定方法
-(void)timerBtnClick
{
    [self sysConfigRootWebviewController];
}
#pragma mark - 倒计时和点击立即结束需要执行的方法
-(void)sysConfigRootWebviewController
{
  
    if ([self.sysmodel.value isEqualToString:@"True"] ) {
        if (self.sysmodel.url!=nil && ![self.sysmodel.url isEqualToString:@"#"]) {
            // 跳转webview
            [self killNSTimer];
            RootWebViewController * webVc = [[RootWebViewController alloc]init];
             webVc.status = enterSysConfig;
            webVc.colorModel = self.colorModel;
            webVc.url = self.sysmodel.url;
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.isFirst = YES;
            //                    [self presentViewController:webVc animated:YES completion:nil];
            [self.navigationController pushViewController:webVc animated:YES];
        }
    }
    else
    {
        // 进入首页
        /*
         1.停止计时器
         2.发送通知更改根式图
         */
        [self closeAdVC];

    }
}
#pragma mark - 启动页面信息数据
-(void)startAppConfig
{
    [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,GetAppConfig] parameters:@{@"format":@"json"} success:^(id responseObject) {
        NSMutableArray * resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        [self.dataArray addObjectsFromArray:[AppStartConfigModel mj_objectArrayWithKeyValuesArray:resultArray]];
         self.sysmodel = (AppStartConfigModel*)self.dataArray[0];
         self.startmodel = (AppStartConfigModel*)self.dataArray[1];
        self.colorModel = (AppStartConfigModel*)self.dataArray[2];
        [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.startmodel.value] placeholderImage:[UIImage imageNamed:@"AppBoot"]];
        NSLog(@"返回数据%@",resultArray);
        /*
         {
         id = 2;
         key = SysConfig;
         value = True;
         url = http://meimei.weilianupup.com/;
         remark = ;
         }
         ,
         {
         id = 3;
         key = AppStartAd;
         value = http://firstapp.weilianup.com/images/appAd.jpg;
         url = http://meimei.weilianupup.com/;
         remark = <null>;
         },
         {
         id = 4;
         key = WebViewTitleColor;
         remark = "<null>";
         url = "<null>";
         value = "#FE5722";
         }
         */
        
      
        
    } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
        NSLog(@"调用失败%@",error);
    }];
    
}


- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}

- (void)closeAdVC{
    [self killNSTimer];
    [self postNoticicationHome]; // 发送通知
}
-(void)postNoticicationHome
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRootViewController" object:@"fromAdVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)killNSTimer{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
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
