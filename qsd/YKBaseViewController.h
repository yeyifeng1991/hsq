//
//  YKBaseViewController.h
//  xiaoqianfeng
//
//  Created by mc on 2017/10/26.
//  Copyright © 2017年 jiucangtouzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKBaseViewController : UIViewController

@property (nonatomic, strong)UIImageView *gifImageView;

- (void)createGIF;
- (void)requestData;

@end
