//
//  UIView+Extension.m
//  QiMu
//
//  Created by XH on 17/4/1.
//  Copyright © 2017年 XH. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX_xh:(CGFloat)x_xh
{
    CGRect frame = self.frame;
    frame.origin.x = x_xh;
    self.frame = frame;
}

- (void)setY_xh:(CGFloat)y_xh
{
    CGRect frame = self.frame;
    frame.origin.y = y_xh;
    self.frame = frame;
}

- (CGFloat)x_xh
{
    return self.frame.origin.x;
}

- (CGFloat)y_xh
{
    return self.frame.origin.y;
}

- (CGFloat)left_xh
{
    return self.frame.origin.x;
}

- (void)setLeft_xh:(CGFloat)left_xh
{
    CGRect frame = self.frame;
    frame.origin.x = left_xh;
    self.frame = frame;
}

- (CGFloat)top_xh
{
    return self.frame.origin.y;
}

- (void)setTop_xh:(CGFloat)top_xh
{
    CGRect frame = self.frame;
    frame.origin.y = top_xh;
    self.frame = frame;
}

- (CGFloat)right_xh
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight_xh:(CGFloat)right_xh
{
    CGRect frame = self.frame;
    frame.origin.x = right_xh - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom_xh {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom_xh:(CGFloat)bottom_xh
{
    CGRect frame = self.frame;
    frame.origin.y = bottom_xh - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width_xh {
    return self.frame.size.width;
}

- (void)setWidth_xh:(CGFloat)width_xh
{
    CGRect frame = self.frame;
    frame.size.width = width_xh;
    self.frame = frame;
}

- (CGFloat)height_xh {
    return self.frame.size.height;
}

- (void)setHeight_xh:(CGFloat)height_xh
{
    CGRect frame = self.frame;
    frame.size.height = height_xh;
    self.frame = frame;
}

- (CGPoint)origin_xh {
    return self.frame.origin;
}

- (void)setOrigin_xh:(CGPoint)origin_xh
{
    CGRect frame = self.frame;
    frame.origin = origin_xh;
    self.frame = frame;
}

- (CGSize)size_xh {
    return self.frame.size;
}

- (void)setSize_xh:(CGSize)size_xh
{
    CGRect frame = self.frame;
    frame.size = size_xh;
    self.frame = frame;
}

- (void)setCenterX_xh:(CGFloat)centerX_xh
{
    CGPoint center = self.center;
    center.x = centerX_xh;
    self.center = center;
}

- (CGFloat)centerX_xh
{
    return self.center.x;
}

- (void)setCenterY_xh:(CGFloat)centerY_xh
{
    CGPoint center = self.center;
    center.y = centerY_xh;
    self.center = center;
}

- (CGFloat)centerY_xh
{
    return self.center.y;
}

@end
