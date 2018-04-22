//
//  adContentCell.h
//  qsd
//
//  Created by mc on 2018/4/21.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface adContentCell : UITableViewCell
@property (nonatomic,strong) UILabel * titleLabel; // 标题数组
@property (nonatomic,strong) UIWebView * webView; // webview用来显示文本
@property (nonatomic,strong) ArticleModel * model; // 字符串
@end
