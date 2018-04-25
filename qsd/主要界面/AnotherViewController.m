//
//  AnotherViewController.m
//  qsd
//
//  Created by mc on 2018/4/24.
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
#import "MBProgressHUD.h"
#import "connectedCell.h" // 相关新闻cell
#import "RootWebViewController.h"
#import "AnotherViewController.h"

@interface AnotherViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property(nonatomic,strong) UITableView * newsTab;
@property (nonatomic,strong) NSMutableArray * adArray; // 广告业数组
@property (nonatomic,strong) NSMutableArray * conNewsArray; // 相关新闻数组
@property (nonatomic,strong) ArticleModel * articleModel;// 新闻详情model
@property (nonatomic,strong) UILabel * titleLabel; // 标题标签
@property (nonatomic,strong) UIWebView * webView; // webview用来显示文本
@property (nonatomic,strong) MBProgressHUD * hud;
@property (nonatomic,assign) CGSize textSize;

@end
static NSString * const  cell1 = @"adscell"; // 广告业的图片 第一区
static NSString * const  cell2 = @"footCell"; // 相关新闻文字 第二区
static NSString * const  cell3 = @"newsCell"; // 相关新闻的图片 第三区


@implementation AnotherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"金讯达";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self getCustomBtn]];
    [self.view addSubview:self.webView];
}
-(UIButton *)getCustomBtn
{
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bigBack"]];
    imageV.frame = CGRectMake(0, 10, 13.5, 25);
    imageV.userInteractionEnabled = YES;
    imageV.contentMode = UIViewContentModeScaleToFill;
    
    UIButton * baseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    baseBtn.frame = CGRectMake(0, 0, 84, 44);
    //    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [baseBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * backLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 25)];
    backLab.textColor = [UIColor whiteColor];
    backLab.text = @"返回";
    backLab.font = [UIFont systemFontOfSize:18];
    [baseBtn addSubview:imageV];
    [baseBtn addSubview:backLab];
    
    
    return baseBtn;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}
-(void)backViewController
{
    //    [self.navigationController pushViewController:[NewSearchViewController new] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 400)];
        _webView.backgroundColor = [UIColor whiteColor];
        //        _webView.backgroundColor = [UIColor redColor];
        _webView.delegate = self;
        //        _webView.scalesPageToFit = YES;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webView;
}

-(void)setModel:(ArticleListModel *)model
{
    if ([self isBlankString:model.id]) {
        [SVProgressHUD showWithStatus:@"暂无数据" duration:3];
        return;
    }
    _model = model;
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.backgroundColor = [UIColor clearColor];
    self.hud.label.text = @"加载中...";
    self.hud.removeFromSuperViewOnHide = YES;
#pragma mark - 新闻页面的详情数据
    [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,ViewArticle] parameters:@{@"id":_model.id,@"format":@"json"}  success:^(id responseObject) {
        NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        self.articleModel = [ArticleModel mj_objectWithKeyValues:result];
        self.textSize = [self sizeForNoticeTitle:self.articleModel.articleName font:[UIFont systemFontOfSize:23]];
        //内容插入
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.textSize.height+20, 0,0,0);
        //偏移量=插入内容高度
        self.webView.scrollView.contentOffset = CGPointMake(0, -(self.textSize.height+20));
        [self.view addSubview:self.newsTab];
        [self.webView loadHTMLString:self.articleModel.articleContent baseURL:nil];
        
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
#pragma mark - 广告业列表数据
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
        [self.newsTab reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];
        
    } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
        NSLog(@"错误%@",error);
    }];
    
    
}
#pragma mark - 获取相关新闻列表
-(void)getConnectedNewsList
{
    NSDictionary * dic = @{@"ArticleType":self.articleModel.articleType,
                           @"PageSize":@5,
                           @"PageIndex":@1,
                           @"format":@"json"};
    [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,GetArticleList] parameters:dic  success:^(id responseObject) {
        
        NSMutableDictionary * resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        //        _page++;
        [self.conNewsArray addObjectsFromArray:[ArticleListModel mj_objectArrayWithKeyValuesArray:resultArray[@"rows"]]];
        [self.newsTab reloadData];
        [self.hud hideAnimated:YES];
    } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
        NSLog(@"失败%@",error);
        [self.hud hideAnimated:YES];
        
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
    if (_adArray == nil) {
        _adArray = [NSMutableArray array];
    }
    return  _adArray;
}
#pragma mark - lazy
- (UITableView *)newsTab
{
    if (!_newsTab) {
        _newsTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _newsTab.dataSource = self;
        _newsTab.delegate = self;
        _newsTab.backgroundColor = [UIColor whiteColor];
        _newsTab.separatorColor = [UIColor clearColor];
        [_newsTab registerNib:[UINib nibWithNibName:@"AdViewsCell" bundle:nil] forCellReuseIdentifier:cell1];
        [_newsTab registerNib:[UINib nibWithNibName:@"connectedCell" bundle:nil] forCellReuseIdentifier:cell2];
        [_newsTab registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:cell3];
    }
    return _newsTab;
}
- (NSMutableArray *)conNewsArray
{
    if (_conNewsArray == nil) {
        _conNewsArray = [NSMutableArray array];
    }
    return _conNewsArray;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //标题label设置
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 30)];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //    LabelSet(titleLabel, self.articleModel.articleName, [UIColor blackColor], 23);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.articleModel.articleName;
    titleLabel.frame = CGRectMake((SCREEN_WIDTH - self.textSize.width) / 2, -self.textSize.height-10, self.textSize.width, self.textSize.height);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.webView.scrollView addSubview:titleLabel];
    
    CGSize  fittingSize = [webView sizeThatFits:CGSizeZero];
    webView.frame = CGRectMake(0, 0, fittingSize.width, fittingSize.height);
    [self.newsTab beginUpdates];
    [self.newsTab setTableHeaderView:webView];
    [self.newsTab endUpdates];
    [self getAdvetiseList];
    [self getConnectedNewsList];
    
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return self.adArray.count;
    }
    else if (section ==1) return 1;
    else
    {
        return self.conNewsArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AdViewsCell * adscell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (!adscell) {
            adscell = [[AdViewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        adscell.selectionStyle = UITableViewCellSelectionStyleNone;
        adModel * model = self.adArray[indexPath.row];
        [adscell.adImageView sd_setImageWithURL:[NSURL URLWithString:model.adPicUrl]];
        //    newscell.timeWithNick.text = model.publishTime;
        return adscell;
    }
    
    else if (indexPath.section ==1)
    {
        connectedCell * concell = [tableView dequeueReusableCellWithIdentifier:cell2];
        if (!concell) {
            concell = [[connectedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        }
        
        return concell;
        
    }
    else
    { // 内容cell
        NewsCell * newscell = [tableView dequeueReusableCellWithIdentifier:cell3];
        if (!newscell) {
            newscell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell3];
        }
        newscell.selectionStyle = UITableViewCellSelectionStyleNone;
        newscell.listModel = (ArticleListModel*)self.conNewsArray[indexPath.row];
        return newscell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RootWebViewController * webVc = [[RootWebViewController alloc]init];
        adModel * model = self.adArray[indexPath.row];
        if ([model.adHref isEqualToString:@"#"]) {
            return;
        }
        webVc.url = model.adPicUrl;
        [self.navigationController pushViewController:webVc animated:YES];
        
    }
    else if (indexPath.section == 2)
    {
        NewsViewController * vc = [[NewsViewController alloc]init];
        vc.model =(ArticleListModel*) self.conNewsArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    return indexPath.section == 0? 80 :101;
    if (indexPath.section ==0) return 80;
    else if (indexPath.section ==1) return 44;
    else return 101;
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
