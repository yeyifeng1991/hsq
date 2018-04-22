//
//  UIResponder+XHRouter.m
//  QiMu
//
//  Created by XH on 17/4/5.
//  Copyright © 2017年 XH. All rights reserved.
//

#import "UIResponder+XHRouter.h"

@implementation UIResponder (XHRouter)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
