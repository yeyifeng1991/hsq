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
@interface ZJVc3Controller ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;

@end

@implementation ZJVc3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱迅达";
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem barButtonRightItemWithImageName:@"searchBtn" target:self action:@selector(searchClick)];

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"借贷热点",
                    @"投资研究",
                    @"深度调研",
                    @"行情分析",
                    @"对话专家",
                    @"学院资讯",
                    ];
    // 初始化
    _scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];

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
