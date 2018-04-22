//
//  YKBaseViewController.m
//  xiaoqianfeng
//
//  Created by mc on 2017/10/26.
//  Copyright © 2017年 jiucangtouzi. All rights reserved.
//

#import "YKBaseViewController.h"
#import "UIImage+GIF.h"
#import "common.h"
#import "Masonry.h"
@interface YKBaseViewController ()

@end

@implementation YKBaseViewController

- (void)dealloc{
    NSLog(@"内存没有泄漏");
}



 - (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view.
 [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
 self.view.backgroundColor = [UIColor whiteColor];
 
 self.navigationController.navigationBar.translucent = NO;
 self.navigationController.navigationBar.barTintColor = RGBHex(0xf37914);
 if (@available(iOS 8.2, *)) {
 [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
 }
 
 self.automaticallyAdjustsScrollViewInsets = NO;
 if (@available(iOS 11, *)) {
 [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
 }
 
 if (self.navigationController.childViewControllers.count > 1) {
 UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
 containView.userInteractionEnabled = YES;
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
 [containView addGestureRecognizer:tap];
 
 UIImageView *arrow = KBACKGROUNDVIEW(@"navigationbuttonreturn");
 [containView addSubview:arrow];
 arrow.frame = CGRectMake(-10, 9.5, 21, 21);
 
 UILabel *backLabel = [[UILabel alloc] init];
 [containView addSubview:backLabel];
 LabelSet(backLabel, @"返回", [[UIColor whiteColor] colorWithAlphaComponent:0.7], 16);
 backLabel.frame = CGRectMake(9, (40 - backLabel.frame.size.height) / 2 - 0.5, backLabel.frame.size.width, backLabel.frame.size.height);
 
 UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:containView];
 self.navigationItem.leftBarButtonItem = leftBarButton;
 }
 }
 
 - (void)requestData{}
 
 //创建gif
 - (void)createGIF {
 self.gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT)];
 [self.view addSubview:self.gifImageView];
 self.gifImageView.image = [UIImage sd_animatedGIFWithData:@"404notfound"];
 self.gifImageView.userInteractionEnabled = YES;
 
 UIButton *reload = [UIButton buttonWithType:UIButtonTypeCustom];
 [self.gifImageView addSubview:reload];
 reload.backgroundColor = RGBHex(0x1e90ff);
 reload.layer.masksToBounds = YES;
 reload.layer.cornerRadius = 6.0;
 [reload setTitle:@"重新加载" forState:UIControlStateNormal];
 [reload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 reload.titleLabel.font = [UIFont systemFontOfSize:18];
 [reload mas_makeConstraints:^(MASConstraintMaker *make) {
 make.width.mas_equalTo(100);
 make.height.mas_equalTo(30);
 make.top.mas_equalTo((SCREEN_HEIGHT - NAVIGATION_HEIGHT) / 2);
 make.left.mas_equalTo((SCREEN_WIDTH - 100) / 2);
 }];
 [reload addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
 }
 
#pragma mark - 其他方法
- (void)back{
    [self back:YES];
}

- (void)back:(BOOL)animated {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
