//
//  UIScrollView+HeaderScaleImage.h
//  YZHeaderScaleImageDemo
//
//  Created by yz on 16/7/29.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HeaderScaleImage)

/**
 *  头部缩放视图图片
 */
@property (nonatomic, strong) UIImage *yz_headerScaleImage;

/**
 *  头部缩放视图图片高度
 */
@property (nonatomic, assign) CGFloat yz_headerScaleImageHeight;

// 移除kvo，必须外部移除，否则在ios9.0以下会对其它scrollView子类有干扰
- (void)removeObserver;

@end
