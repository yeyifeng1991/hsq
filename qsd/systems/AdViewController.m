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
@interface AdViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong)NSTimer *countDownTimer;

@end

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
    [self createSubviews];
    [self networkDetectionAndSetting];
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

- (void)createSubviews{
    //背景图，临时设置为开机动画，后面要更改为网络请求的图片
    _backgroundImageView = KBACKGROUNDVIEW(@"AppBoot");
    [self.view addSubview:_backgroundImageView];
    _backgroundImageView.frame = self.view.bounds;
    _backgroundImageView.userInteractionEnabled = YES;
    
    //倒计时按钮
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundImageView addSubview:_closeBtn];
    [_closeBtn setTitle:@"5s" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:RGBHex(0x3b3a3e) forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptationWidth(14)];
    [_closeBtn addTarget:self action:@selector(closeAdVC) forControlEvents:UIControlEventTouchUpInside];
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

//定时器执行方法
- (void)countDownAction{
    _secondCountDown --;
    [_closeBtn setTitle:[NSString stringWithFormat:@"%@s",@(_secondCountDown)] forState:UIControlStateNormal];
    if (_secondCountDown == 0) {
        [self closeAdVC];
    }
}
#pragma mark - 启动页面信息数据
-(void)startAppConfig
{
    [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,GetAppConfig] parameters:@{@"format":@"json"} success:^(id responseObject) {
        NSMutableArray * resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        [self.dataArray addObjectsFromArray:[AppStartConfigModel mj_objectArrayWithKeyValuesArray:resultArray]];
        AppStartConfigModel * model = (AppStartConfigModel*)self.dataArray[0];
        /*
         逻辑
         if value = True; 5s ->webview
         if value = false; 正常流程
         */
    } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [SVProgressHUD showWithStatus:@"点击进入广告界面"];
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
