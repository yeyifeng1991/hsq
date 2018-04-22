//
//  UIView+YYFBadge.h
//  QiMu
//
//  Created by YeYiFeng on 17/1/6.
//  Copyright © 2017年 XH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^notice)(BOOL  isExist);
@interface UIView (YYFBadge)
/**
 *  通过创建label，显示小红点；
 */
@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIImageView * emptyView; //页面无数据的视图
- (void)showEmptyView; //显示空白页面
- (void)hidenEmptyView;//隐藏空数据页面

/**
 *  显示小红点
 */
- (void)showBadge;

/**
 * 显示几个小红点儿
 * parameter redCount 小红点儿个数
 */
- (void)showBadgeWithCount:(NSInteger)redCount;

/**
 *  隐藏小红点
 */
- (void)hidenBadge;

//是否存在未读消息
-(void)isUnreadMsgExistWithTYpe:(NSString *)mastype withBlock:(notice)isMsg;
@end
