//
//  ZJVc3Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc3Controller.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"
#import "UIBarButtonItem+XHExtension.h"
#import "NewSearchViewController.h"
#import "common.h"
#import "NetworkManager.h"
#import "titleModel.h"
#import "MJExtension.h"
#import "SVProgressHUD+XH.h"
@interface ZJVc3Controller ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSMutableArray<NSString *> *titles; // 标题数组
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@property (nonatomic,strong) NSMutableArray * dataArray;// 请求标题栏model数组


@end

@implementation ZJVc3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"金讯达";
    self.titles = [XHDefault objectForKey:@"titleArray"];
    if (self.titles) {
        
    }
    else
    {
          NSArray * array = @[@"借贷热点",
                            @"投资研究",
                            @"深度调研",
                            @"行情分析",
                            @"对话专家",
                            @"学院资讯",
                            ];
        self.titles = [NSMutableArray arrayWithArray:array];
    }
    [self setTopViewData];

//    [self getAticleTitleList];
    
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem barButtonRightItemWithImageName:@"searchBtn" target:self action:@selector(searchClick)];
   
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)titles
{
    if (!_titles ) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
#pragma mark - 获取顶部标题栏
-(void)getAticleTitleList
{
    [SVProgressHUD showWithStatus:@"正在加载中"];
    [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,TitleList] parameters:@{@"format":@"json"} success:^(id responseObject) {
        NSMutableDictionary * resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
          [self.dataArray addObjectsFromArray:[titleModel mj_objectArrayWithKeyValuesArray:resultArray]];
        for (titleModel * model in self.dataArray) {
            [self.titles addObject:model.value];
        }
        [XHDefault setObject:self.titles forKey:@"titleArray"];
        [XHDefault synchronize];
        [SVProgressHUD dismiss];
        [self setTopViewData];
        
    } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
        [SVProgressHUD dismiss];

    }];
    
}
-(void)setTopViewData
{
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    style.scrollTitle = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
//    self.titles = @[@"借贷热点",
//                    @"投资研究",
//                    @"深度调研",
//                    @"行情分析",
//                    @"对话专家",
//                    @"学院资讯",
//                    ];
    // 初始化
    _scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - NAVIGATION_HEIGHT) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:_scrollPageView];
}
#pragma mark - SELECTOR
-(void)searchClick
{
    [self.navigationController pushViewController:[NewSearchViewController new] animated:YES];
}
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[ZJTestViewController alloc] init];
    }
    
//    NSLog(@"%ld-----%@",(long)index, childVc);
    
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}


@end
