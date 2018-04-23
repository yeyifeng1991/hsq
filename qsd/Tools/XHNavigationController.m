//
//  XHNavigationController.m
//  b2b
//
//  Created by XH on 16/9/12.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "XHNavigationController.h"
#import "common.h"
@interface XHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = nil;
    [self addGestureRecognizer];
    
}

- (void)loadView {
    [super loadView];
     //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:XHColor(0x333333)}];
    self.navigationItem.hidesBackButton = YES;
    UIImage *image1 = [UIImage imageNamed:@"back"];
    UIImage *image2 = [UIImage imageNamed:@"back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, image1.size.width-1, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image2 resizableImageWithCapInsets:UIEdgeInsetsMake(0, image2.size.width-1, 0, 0)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:XHColor(0x333333)];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)addGestureRecognizer {
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    //获取系统手势的target数组
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    //获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
    id gestureRecognizerTarget = [_targets firstObject];
    //获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    //通过前面的打印，我们从控制台获取出来它的方法签名。
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    //创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
    
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:touch.view];
    
    CGFloat absX = fabs(touchLocation.x);
    CGFloat absY = fabs(touchLocation.y);
    
    // 设置滑动有效距离
    if (MAX(absX, absY) < 10)
        return NO;
    
    if (absX > absY ) {
        
        if (touchLocation.x<0) {
            
            //向左滑动
            return YES;
        }else{
            //向右滑动
            return NO;
        }
        
    } else if (absY > absX) {
        if (touchLocation.y<0) {
            
            //向上滑动
            return YES;
        }else{
            
            //向下滑动
            return YES;
        }
    }
    
    return  YES;
}

#pragma mark -  push 设置
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    for (Class classes in self.rootVcAry) {
        if ([viewController isKindOfClass:classes]) {
            if (self.navigationController.viewControllers.count > 0) {
                viewController.hidesBottomBarWhenPushed = YES;
            } else {
                viewController.hidesBottomBarWhenPushed = NO;
            }
        } else {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark -  RootVc

- (NSMutableArray *)rootVcAry {
    if (!_rootVcAry) {
        _rootVcAry = [NSMutableArray new];
    }
    return _rootVcAry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
