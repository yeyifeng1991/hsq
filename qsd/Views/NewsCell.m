//
//  NewsCell.m
//  qsd
//
//  Created by mc on 2018/4/20.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"


@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setListModel:(ArticleListModel *)listModel
{
    _listModel = listModel;
//    self.newsImgView sd_setImageWithURL:[NSURL URLWithString:listModel.]
    self.newsLab.text = _listModel.source;
    self.timeWithNick.text= [NSString stringWithFormat:@"%@  %@",_listModel.publishTime,_listModel.author];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
