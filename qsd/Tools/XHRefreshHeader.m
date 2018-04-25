//
//  XHRefreshHeader.m
//  QiMu
//
//  Created by XH on 16/12/2.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "XHRefreshHeader.h"

@implementation XHRefreshHeader

- (void)prepare
{
    [super prepare];
    
//    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=18; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
//    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"%d", 1]];
//    UIImage *image2 = [UIImage imageNamed:[NSString stringWithFormat:@"%d", 5]];
//    UIImage *image3 = [UIImage imageNamed:[NSString stringWithFormat:@"%d", 10]];
//    UIImage *image4 = [UIImage imageNamed:[NSString stringWithFormat:@"%d", 15]];
//    [refreshingImages addObject:image1];
//    [refreshingImages addObject:image2];
//    [refreshingImages addObject:image3];
//    [refreshingImages addObject:image4];
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//   
//    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
