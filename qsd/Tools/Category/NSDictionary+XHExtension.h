//
//  NSDictionary+XHExtension.h
//  QiMu
//
//  Created by XH on 17/4/5.
//  Copyright © 2017年 XH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XHExtension)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr;

- (NSString*)jsonString;

@end
