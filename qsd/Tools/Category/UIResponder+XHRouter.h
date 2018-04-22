//
//  UIResponder+XHRouter.h
//  QiMu
//
//  Created by XH on 17/4/5.
//  Copyright © 2017年 XH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (XHRouter)

// router message and the responder who you want will respond this method
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
