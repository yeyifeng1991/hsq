//
//  TextViewController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTestViewController.h"
#import "UIViewController+ZJScrollPageController.h"
//#import "ZJTest1Controller.h"
//#import "ZJTest2ViewController.h"
#import "common.h"
#import "NewsCell.h"
#import "UIBarButtonItem+XHExtension.h"
#import "NewSearchViewController.h"
#import "NewsViewController.h"
#import "NetworkManager.h"
#import "HttpManager.h" // 小钱蜂的网络请求
#import "ArticleListModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import "XHWebVC.h"
#import "RootWebViewController.h"
#import "XHWebVC.h"
#import "SVProgressHUD+XH.h"
#import "XHRefreshHeader.h"
@interface ZJTestViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _page;
    NSInteger _articleType;
}
@property(nonatomic,strong) UITableView * newsTab;
@property (nonatomic, strong) NSMutableArray *dataArray; // 当前页面数据类

@end
static  NSString * cell = @"newsCell";

@implementation ZJTestViewController
- (IBAction)testBtnOnClick:(UIButton *)sender {
//    ZJTest2ViewController *test = [ZJTest2ViewController new];
//    [self showViewController:test sender:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor whiteColor];
    _articleType = 1;
    self.extendedLayoutIncludesOpaqueBars = YES;

    [self.view addSubview:self.newsTab];
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    header.stateLabel.hidden = YES;
    self.newsTab.mj_header = header;
//    self.newsTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.newsTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    self.newsTab.mj_footer = footer;
}


- (void)zj_viewDidLoadForIndex:(NSInteger)index {

}

#pragma mark - 数据处理
- (void)loadDataSource
{
     NSDictionary * dic = @{@"ArticleType":[NSString stringWithFormat:@"%ld",_articleType],
                             @"PageSize":@10,
                             @"PageIndex":[NSString stringWithFormat:@"%ld",_page],
                             @"format":@"json"};
     [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,GetArticleList] parameters:dic  success:^(id responseObject) {
      NSMutableDictionary * resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
         _page++;
         [self.dataArray addObjectsFromArray:[ArticleListModel mj_objectArrayWithKeyValuesArray:resultArray[@"rows"]]];
         [self.newsTab reloadData];
         if (self.dataArray.count == [resultArray[@"total"] integerValue]) {
             [self.newsTab.mj_footer resetNoMoreData];
             [self.newsTab.mj_footer endRefreshingWithNoMoreData];
         }else{
             [self.newsTab.mj_footer endRefreshing];
         }
         [self.newsTab.mj_header endRefreshing];
     } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
       NSLog(@"失败%@",error);
         _page--;
         [self.newsTab.mj_header endRefreshing];
         [self.newsTab.mj_footer endRefreshing];
     }];
    
    
}
- (void)loadNewData
{
    _page = 1;
    if (self.dataArray.count >0) {
        [self.dataArray removeAllObjects];
    }
    [self loadDataSource];
}
- (void)loadMoreData
{
    [self loadDataSource];
}
#pragma mark - lazy
- (UITableView *)newsTab
{
    if (!_newsTab) {
        _newsTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40-64) style:UITableViewStylePlain];
        _newsTab.dataSource = self;
        _newsTab.delegate = self;
        _newsTab.emptyDataSetSource = self;
        _newsTab.emptyDataSetDelegate = self;
        _newsTab.tableFooterView = [UIView new];
        _newsTab.separatorColor = [UIColor clearColor];
        [_newsTab registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:cell];
    }
    return _newsTab;
}
- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell * newscell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (!newscell) {
        newscell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
    }
    newscell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count >0) {
        newscell.listModel = (ArticleListModel*)self.dataArray[indexPath.row];

    }
   
    return newscell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  101;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.dataArray.count >0) {
        ArticleListModel * model = self.dataArray[indexPath.row];
       
        if (![model.topicUrl isEqualToString:@"#"] && model.topicUrl != nil ) {

             RootWebViewController * webVc = [[RootWebViewController alloc]init];
             webVc.url = model.topicUrl;
             webVc.status = enterAppStarted;
             //        webVc.hidesBottomBarWhenPushed = YES;
             webVc.isFirst = NO;
             [self.navigationController pushViewController:webVc animated:YES];
     

        }
        
        else // 跳详情
        {
             [SVProgressHUD showWithStatus:@"加载中"];
            NewsViewController * newsVc = [[NewsViewController alloc]init];
            newsVc.model = model;
            [self.navigationController pushViewController:newsVc animated:YES];
        }

    }

    
    
}
-(UIColor*)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"Empty"];
    
}
 // 使用系统的生命周期方法
 - (void)viewWillAppear:(BOOL)animated {
      [super viewWillAppear:animated];
     
     self.navigationController.navigationBar.translucent = YES;
//     self.navigationController.navigationBar.hidden = NO;
     _articleType = self.zj_currentIndex+1;
     [self loadNewData];
 }
 
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 NSLog(@"viewDidAppear-----%ld", self.zj_currentIndex);
 
 }


 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 NSLog(@"viewDidDisappear--------%ld", self.zj_currentIndex);
 
 }



// 使用ZJScrollPageViewChildVcDelegate提供的生命周期方法

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    NSLog(@"viewDidDisappear--------");
//
//}
//- (void)zj_viewWillAppearForIndex:(NSInteger)index {
//    NSLog(@"viewWillAppear------");
//    
//}
//
//
//- (void)zj_viewDidAppearForIndex:(NSInteger)index {
//    NSLog(@"viewDidAppear-----");
//    
//}
//
//
//- (void)zj_viewWillDisappearForIndex:(NSInteger)index {
//    NSLog(@"viewWillDisappear-----");
//
//}
//
//- (void)zj_viewDidDisappearForIndex:(NSInteger)index {
//    NSLog(@"viewDidDisappear--------");
//
//}


- (void)dealloc
{
    [self.newsTab setDelegate:nil];
    @try {
        

    }
    @catch (NSException *exception) {
        NSLog(@"ZJTestViewControllerException: %@", exception);
    }
    @finally  {
        // Added to show finally works as well
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
