//
//  NewsCell.h
//  qsd
//
//  Created by mc on 2018/4/20.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleListModel.h"
@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsLab;
@property (weak, nonatomic) IBOutlet UIImageView *newsImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeWithNick;
@property (weak, nonatomic) IBOutlet UIImageView *isAd;
@property (nonatomic,strong) ArticleListModel * listModel;
@end
