//
//  adContentCell.m
//  qsd
//
//  Created by mc on 2018/4/21.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "adContentCell.h"
#import "Masonry.h"
@implementation adContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
   
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(58);
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    self.webView = [[UIWebView alloc]init];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
}
/*
 - (void)setLoanStrategy:(LoanStrategyModel *)loanStrategy{
 _loanStrategy = loanStrategy;
 
 NSURL *url = [NSURL URLWithString:[URL_api stringByAppendingString:_loanStrategy.iconSrc]];
 [self.iconImageView sd_setImageWithURL:url];
 
 //富文本
 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[%@] %@", _loanStrategy.strategyType, _loanStrategy.strategyName]];
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 [paragraphStyle setLineSpacing:8];//调整行间距
 [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
 [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0xff4500) range:NSMakeRange(0, 6)];
 //将富文本复制给label的富文本Text
 self.titleLabel.attributedText = attributedString;
 self.titleLabel.backgroundColor = [UIColor redColor];
 
 //富文本
 NSString *readCountStr = [NSString stringWithFormat:@"%@ 人阅读", _loanStrategy.readCount];
 NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:readCountStr];
 [attributedString2 addAttribute:NSForegroundColorAttributeName value:RGBHex(0x1E90FF) range:NSMakeRange(0, readCountStr.length - 3)];
 //将富文本复制给label的富文本Text
 self.readLabel.attributedText = attributedString2;
 self.readLabel.backgroundColor = [UIColor cyanColor];
 
 [self.readLabel sizeToFit];
 [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 if (IS_IPHONE5()) {
 make.right.mas_equalTo(-18);
 make.bottom.mas_equalTo(-3);
 }else{
 make.bottom.and.right.mas_equalTo(-18);
 }
 }];
 }
 */
- (void)setModel:(ArticleModel *)model
{
    _model = model;
    self.titleLabel.text = model.articleName;
    [self.webView loadHTMLString:model.articleContent baseURL:nil];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
