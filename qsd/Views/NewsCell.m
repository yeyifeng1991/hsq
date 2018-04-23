//
//  NewsCell.m
//  qsd
//
//  Created by mc on 2018/4/20.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "common.h"

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setListModel:(ArticleListModel *)listModel
{
    _listModel = listModel;
//    self.newsImgView sd_setImageWithURL:[NSURL URLWithString:listModel.IconSrc]
    NSString * imgUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,_listModel.iconSrc];
    [self.newsImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"newsError"]];
    self.newsLab.text = _listModel.articleName;
    self.timeWithNick.text= [NSString stringWithFormat:@"%@  %@",_listModel.publishTime,[self isBlankString:_listModel.author]?@"":_listModel.author];
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
