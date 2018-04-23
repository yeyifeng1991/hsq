//
//  MainViewController.m
//  qsd
//
//  Created by mc on 2018/4/20.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkManager.h"
#import "ZJVc3Controller.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"财经新闻";
    self.view.backgroundColor = [UIColor orangeColor];
    [[NetworkManager shareNetworkManager]GETUrl:@"https://www.baidu.com" parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
        NSLog(@"%@",error);
    }];
    [self.navigationController pushViewController:[ZJVc3Controller new] animated:YES];
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
