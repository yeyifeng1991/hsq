//
//  NewSearchViewController.m
//  qsd
//
//  Created by mc on 2018/4/20.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "NewSearchViewController.h"
#import "common.h"
#import "ZJTestViewController.h"
#import "UIViewController+ZJScrollPageController.h"
#import "common.h"
#import "NewsCell.h"
#import "UIBarButtonItem+XHExtension.h"
#import "NewsViewController.h"
#import "NetworkManager.h"
#import "HttpManager.h" // 小钱蜂的网络请求
#import "ArticleListModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface NewSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _page;
}
@property(nonatomic,strong) UITableView * newsTab;
//@property (nonatomic, strong) NSMutableArray *dataArray; // 当前页面数据类
@property (nonatomic, strong) NSMutableArray *searchArray; // 当前页面数据类

@property(nonatomic,strong)UISearchBar *searchBar; // 搜索栏

@end

static  NSString * cell = @"newsCell";
@implementation NewSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _page = 1;
    [self.view addSubview:self.newsTab];
    [self.navigationItem setHidesBackButton:YES]; // 设置返回按钮为隐藏
    self.navigationItem.titleView = self.searchBar; // 顶部搜索栏的设置
    self.navigationItem.titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 40, 34);

}

-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 34)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索相关信息";
        _searchBar.layer.borderWidth = 1.0f;
        _searchBar.layer.cornerRadius = 5.0f;
//        _searchBar.showsCancelButton = YES;
        _searchBar.layer.borderColor = [UIColor clearColor].CGColor;
//        _searchBar.layer.borderColor = [UIColor grayColor].CGColor;
        
        UIView * searchBarView = [[UIView alloc]init];
        searchBarView.backgroundColor = [UIColor clearColor];
        _searchBar.clipsToBounds = YES;
        [searchBarView addSubview:_searchBar];
        
    }
    return _searchBar;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
    [self loadDataSource:searchText];
}
- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if (self.searchArray.count >0) {
        [self.searchArray removeAllObjects];
        [self.newsTab reloadData];
    }
   
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        
        _searchBar.showsCancelButton = YES;
        for (id obj in [searchBar subviews]) {
            if ([obj isKindOfClass:[UIView class]]) {
                for (id obj2 in [obj subviews]) {
                    if ([obj2 isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)obj2;
                        [btn setTitle:@"取消" forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
        
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
{
    searchBar.showsCancelButton = NO;
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 数据处理
- (void)loadDataSource:(NSString * )nameStr
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"10" forKey:@"PageSize"];
    [dic setValue:@"json" forKey:@"format"];
    [dic setValue:[NSString stringWithFormat:@"%ld",_page] forKey:@"PageIndex"];
    if (![self isBlankString:nameStr]) { // 搜索栏有数据时,才设置调用参数
        [dic setValue:nameStr forKey:@"Name"];
        [[NetworkManager shareNetworkManager] GETUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,GetArticleList] parameters:dic  success:^(id responseObject) {
            if (self.searchArray.count>0) {
                [self.searchArray removeAllObjects];
            }
            NSMutableDictionary * resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
            //        NSLog(@"拿到搜索%@",resultArray);
            [self.searchArray addObjectsFromArray:[ArticleListModel mj_objectArrayWithKeyValuesArray:resultArray[@"rows"]]];
            NSLog(@"网络请求中个数%ld",self.searchArray.count);
            //        _page++;
            [self.newsTab reloadData];
        } failure:^(NSError *error, ParamtersJudgeCode judgeCode) {
            NSLog(@"失败%@",error);
            //        _page--;
            
            //        [self.newsTab reloadData];
        }];
    }
    NSLog(@"输入参数%@",dic);
    
 
    
    
}
#pragma mark - lazy
- (UITableView *)newsTab
{
    if (!_newsTab) {
        _newsTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _newsTab.dataSource = self;
        _newsTab.delegate = self;
        _newsTab.separatorColor = [UIColor clearColor];
        [_newsTab registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:cell];
    }
    return _newsTab;
}
- (NSMutableArray *)searchArray
{
    if (nil == _searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return  _searchArray;
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell * newscell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (!newscell) {
        newscell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
    }
    newscell.selectionStyle = UITableViewCellSelectionStyleNone;
//    ArticleListModel * model = self.searchArray[indexPath.row];
    newscell.listModel = (ArticleListModel*)self.searchArray[indexPath.row];
    return newscell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  101;
}
// 判断是否为空
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
