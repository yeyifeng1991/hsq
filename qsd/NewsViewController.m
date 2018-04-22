//
//  NewsViewController.m
//  qsd
//
//  Created by mc on 2018/4/20.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "NewsViewController.h"
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
#import "XYHttpManager.h"
#import "HttpManager.h" // 小钱蜂的网络请求
#import "ArticleListModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SVProgressHUD+XH.h"
#import "adModel.h"
#import "ArticleModel.h"
#import "AdViewsCell.h"
#import "UIImageView+WebCache.h"
#import "adContentCell.h" //带有webview加载标签的cell
#import "TempViewViewController.h"
#import "MBProgressHUD.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property(nonatomic,strong) UITableView * newsTab;
@property (nonatomic,strong) NSMutableArray * adArray; // 广告业数组
@property (nonatomic,strong) ArticleModel * articleModel;// 新闻详情model
@property (nonatomic,strong) UILabel * titleLabel; // 标题标签
@property (nonatomic,strong) UIWebView * webView; // webview用来显示文本
@property (nonatomic,strong) MBProgressHUD * hud;
@property (nonatomic,assign) CGSize textSize;

@end
static NSString * const  cell1 = @"contentCell"; // 广告业的图片
static NSString * const  cell2 = @"adscell"; // 广告业的图片

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新闻页面";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.backgroundColor = [UIColor clearColor];
    self.hud.label.text = @"加载中...";
    self.hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.newsTab];
    
    
}
-(UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 400)];
        _webView.backgroundColor = [UIColor redColor];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webView;
}
#pragma mark - SELECTOR
-(void)searchClick
{
    TempViewViewController * vc = [[TempViewViewController alloc]init];
    vc.model = self.articleModel;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)setModel:(ArticleListModel *)model
{
    [self getAdvetiseList];
    if ([self isBlankString:model.id]) {
        [SVProgressHUD showWithStatus:@"暂无数据" duration:3];
        return;
    }
#pragma mark - 新闻页面的详情数据
     [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,ViewArticle] parameters:@{@"id":@"1",@"format":@"json"}  success:^(id responseObject) {
     NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
         self.articleModel = [ArticleModel mj_objectWithKeyValues:result];
         self.textSize = [self sizeForNoticeTitle:self.articleModel.articleName font:[UIFont systemFontOfSize:23]];
         //内容插入
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.textSize.height+20, 0, 0, 0);
         //偏移量=插入内容高度
         self.webView.scrollView.contentOffset = CGPointMake(0, -(self.textSize.height+20));
         [self.webView loadHTMLString:self.articleModel.articleContent baseURL:nil];
         [self getConnectedNewsList];
     } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
     NSLog(@"失败%@",error);
     
     }];
}
-(CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font{
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat maxWidth = screen.size.width;
    CGSize maxSize = CGSizeMake(maxWidth-20, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [text boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
        textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return textSize;
}
#pragma mark - 广告业数据
-(void)getAdvetiseList {
 
     NSDictionary * addic = @{@"AdPosition":@"资讯详情",
                             @"PageSize":@3,
                             @"AdAppType":@"app",
                             @"PageIndex":@"1",
                             @"format":@"json",
                             };
     [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,GetAdList] parameters:addic success:^(id responseObject) {
     NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
         [self.adArray addObjectsFromArray:[adModel mj_objectArrayWithKeyValuesArray:result[@"rows"]]];
         NSLog(@"数据内容个数%ld",self.adArray.count);
         
         [self.newsTab reloadData];
     } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
     NSLog(@"错误%@",error);
     }];
    
}
#pragma mark - 获取相关新闻列表
-(void)getConnectedNewsList
{
    NSDictionary * dic = @{@"ArticleType":self.articleModel.articleType,
                           @"PageSize":@2,
                           @"PageIndex":@1,
                           @"format":@"json"};
    [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,GetArticleList] parameters:dic  success:^(id responseObject) {
        
        NSMutableDictionary * resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
//        _page++;
//        [self.dataArray addObjectsFromArray:[ArticleListModel mj_objectArrayWithKeyValuesArray:resultArray[@"rows"]]];
        [self.newsTab reloadData];
//        if (self.dataArray.count == [resultArray[@"total"] integerValue]) {
//            [self.newsTab.mj_footer resetNoMoreData];
//            [self.newsTab.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            [self.newsTab.mj_footer endRefreshing];
//        }
//        [self.newsTab.mj_header endRefreshing];
    } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
        NSLog(@"失败%@",error);
        
    }];

}
-  (BOOL)isBlankString:(NSString *)string {
   
    if (string == nil || string == NULL) {

          return YES;

       }

    if ([string isKindOfClass:[NSNull class]]) {

             return YES;

        }

    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {

            return YES;

         }

     return NO;
   
}
- (NSMutableArray *)adArray
{
    if (nil == _adArray) {
        _adArray = [NSMutableArray array];
    }
    return  _adArray;
}
#pragma mark - lazy
- (UITableView *)newsTab
{
    if (!_newsTab) {
        _newsTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _newsTab.dataSource = self;
        _newsTab.delegate = self;
        [_newsTab registerClass:[adContentCell class] forCellReuseIdentifier:cell1];
        [_newsTab registerNib:[UINib nibWithNibName:@"AdViewsCell" bundle:nil] forCellReuseIdentifier:cell2];
    }
    return _newsTab;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.hud hideAnimated:YES];
    //标题label设置
    //标题label设置
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

    [self.webView.scrollView addSubview:titleLabel];
    LabelSet(titleLabel, self.articleModel.articleName, [UIColor blackColor], 23);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.articleModel.articleName;
    titleLabel.frame = CGRectMake((SCREEN_WIDTH - self.textSize.width) / 2, -self.textSize.height-10, self.textSize.width, self.textSize.height);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    CGSize  fittingSize = [webView sizeThatFits:CGSizeZero];
    webView.frame = CGRectMake(0, 0, fittingSize.width, fittingSize.height);
    [self.newsTab beginUpdates];
    [self.newsTab setTableHeaderView:webView];
    [self.newsTab endUpdates];
    
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.adArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 1) {
        AdViewsCell * adscell = [tableView dequeueReusableCellWithIdentifier:cell2];
        if (!adscell) {
            adscell = [[AdViewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        }
        adscell.selectionStyle = UITableViewCellSelectionStyleNone;
        adModel * model = self.adArray[indexPath.row];
        [adscell.adImageView sd_setImageWithURL:[NSURL URLWithString:model.adPicUrl]];
        //    newscell.timeWithNick.text = model.publishTime;
        return adscell;
//    }
    /*
     else
     { // 内容cell
     adContentCell * ContentCell = [tableView dequeueReusableCellWithIdentifier:cell1];
     if (!ContentCell) {
     ContentCell = [[adContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
     }
     ContentCell.selectionStyle = UITableViewCellSelectionStyleNone;
     ContentCell.model = self.articleModel;
     return ContentCell;
     }
     */
   
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showWithStatus:@"点击广告页面" duration:2];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return 270;
//    }
//    return  80;
    return 80;
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
