//
//  UIView+YYFBadge.m
//  QiMu
//
//  Created by YeYiFeng on 17/1/6.
//  Copyright © 2017年 XH. All rights reserved.
//

#import "UIView+YYFBadge.h"
#import <objc/runtime.h>
static char badgeViewKey;
static NSInteger const pointWidth = 6; //小红点的宽高
static NSInteger const rightRange = 2; //距离控件右边的距离
static CGFloat const badgeFont = 9; //字体的大小

@implementation UIView (YYFBadge)

-(void)isUnreadMsgExistWithTYpe:(NSString *)mastype withBlock:(notice)isMsg;
{
    [XHSaleHttpTask isUnreadMsgExist:@{@"msgType":mastype,@"userCode":[XHUserModel sharedXHUserModel].userInfo.code} success:^(id result) {
        NSDictionary * dic = result[@"data"];
        isMsg([dic[@"isExist"] boolValue]); //返回需要调用的参数
    } failure:^(XHResultCode *result) {
        isMsg(NO);
    }];
}
//显示红色角标
-(void)showBadge
{
    if (self.badge == nil)
    {
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) - rightRange*8, pointWidth, pointWidth, pointWidth);
        self.badge = [[UILabel alloc] initWithFrame:frame];
        self.badge.backgroundColor = [UIColor redColor];
        //圆角为宽度的一半
        self.badge.layer.cornerRadius = pointWidth / 2;
        //确保可以有圆角
        self.badge.layer.masksToBounds = YES;
        [self addSubview:self.badge];//添加到父视图上

    }
}
//显示空背景页面
- (void)showEmptyView{
    
    if (self.emptyView == nil) {
        self.emptyView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
        self.emptyView.image = [UIImage imageNamed:@"数据出错"];
        self.emptyView.userInteractionEnabled = YES;
        [self addSubview:self.emptyView];
        
    }
}
-(void)layoutSubviews
{
    [self bringSubviewToFront:self.badge];//放到上方
    [self bringSubviewToFront:self.emptyView]; //放到上面呢
    
}
- (void)showBadgeWithCount:(NSInteger)redCount
{
    if (redCount < 0) {
        return;
    }
    [self showBadge];
    self.badge.textColor = [UIColor whiteColor];
    self.badge.font = [UIFont systemFontOfSize:badgeFont];
    self.badge.textAlignment = NSTextAlignmentCenter;
    self.badge.text = (redCount > 99 ? [NSString stringWithFormat:@"99+"] : [NSString stringWithFormat:@"%@", @(redCount)]);
    [self.badge sizeToFit];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    frame.origin.y = -frame.size.height / 2;
    if (CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}
//移除红色图标
- (void)hidenBadge
{
    //从父视图上面移除
    [self.badge removeFromSuperview];
}
//移除空数据的背景图
- (void)hidenEmptyView{
    [self.emptyView removeFromSuperview];
}
-(UILabel *)badge
{
  // 通过runtime 获得label的属性
  return objc_getAssociatedObject(self, &badgeViewKey);
}

-(void)setBadge:(UILabel *)badge
{
  objc_setAssociatedObject(self, &badgeViewKey, badge, OBJC_ASSOCIATION_RETAIN);
}
- (UIImageView *)emptyView{
    return objc_getAssociatedObject(self, &badgeViewKey);
}
- (void)setEmptyView:(UIImageView *)emptyView{
    objc_setAssociatedObject(self, &badgeViewKey, emptyView, OBJC_ASSOCIATION_RETAIN);
}
@end
