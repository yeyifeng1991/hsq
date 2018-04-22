//
//  UIBarButtonItem+Common.m
//  QiMu
//
//  Created by YeYiFeng on 16/12/21.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "UIBarButtonItem+Common.h"

@implementation UIBarButtonItem (Common)
//返回纯文字的导航栏
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:obj action:selector];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateDisabled];
    return buttonItem;
}

+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title image:(UIImage *)image target:(id)obj action:(SEL)selector{
    UIButton* rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 48, 50);
    [rightButton setTitle:title forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [rightButton setImage:image forState:UIControlStateNormal];
    // 调button上的图和文字
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    [rightButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem= [[UIBarButtonItem alloc] initWithCustomView:rightButton];
   
    return buttonItem;
}
//返回纯图片的导航栏
+ (UIBarButtonItem *)itemWithBtnImage:(UIImage *)image target:(id)obj action:(SEL)selector;
{
    UIButton* rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 18, 22);
//    rightButton.backgroundColor = [UIColor cyanColor];
//    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightButton setBackgroundImage:image forState:UIControlStateNormal];
    [rightButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem= [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    return buttonItem;
}
//返回图片上方有红点的图标
+ (UIBarButtonItem *)itemWithBtnImage:(UIImage *)image withTipView:(BOOL)hidden target:(id)obj action:(SEL)selector;
{
    UIButton* rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    //    rightButton.backgroundColor = [UIColor cyanColor];
    [rightButton setBackgroundImage:image forState:UIControlStateNormal];
    [rightButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(18, 2, 10, 10)]; //设置右上角的小图标
    redView.backgroundColor = [UIColor redColor];
    redView.layer.masksToBounds = YES;
    
    redView.layer.cornerRadius =5;
    redView.hidden = hidden;
    [rightButton addSubview:redView];
    
    UIBarButtonItem *buttonItem= [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    return buttonItem;

}
#pragma mark----自定义的角标 有文字 有图片
+ (UIBarButtonItem *)itemWithBtnTitle:(NSInteger )title Iconimage:(UIImage *)image target:(id)obj action:(SEL)selector
{
    
    UIButton* rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 48, 48);
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    rightButton.backgroundColor  = [UIColor cyanColor];
    rightButton.titleLabel.textColor = [UIColor blackColor];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
   rightButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
    // 调button上的图和文字
//    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 30)];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
//    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    [rightButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 15, 15)];//添加右侧的角图标
    //    label.backgroundColor=[UIColor colorWithHex:@"#d2d2d2" alpha:1];
    label.backgroundColor=[UIColor orangeColor];
    label.textAlignment=NSTextAlignmentCenter;
    
    label.textColor=[UIColor blackColor];
    label.layer.masksToBounds=YES;
    label.layer.cornerRadius=7.5;
    label.layer.borderWidth=0.5f;
    label.layer.shouldRasterize=YES;
    label.layer.rasterizationScale=[UIScreen mainScreen].scale;
    label.layer.borderColor=[[UIColor redColor]CGColor];
    if (title>99)
    {
        label.font=[UIFont systemFontOfSize:7];
        label.frame=CGRectMake(7, 10, 20, 15);
        label.text=[NSString stringWithFormat:@"99+"];
        
    }
    else if(title>10)
    {
        label.font=[UIFont systemFontOfSize:7];
        label.text=[NSString stringWithFormat:@"%ld",(long)title];
    }
    else
    {
        label.font=[UIFont systemFontOfSize:10];
        label.text=[NSString stringWithFormat:@"%ld",(long)title];
    }
    if (title==0)
    {
        label.hidden=YES;
        
    }
    [rightButton addSubview:label];
    UIBarButtonItem *buttonItem= [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    return buttonItem;
    
}
@end
