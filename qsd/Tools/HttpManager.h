//
//  HttpManager.h
//
//  Created by zcx on 15/3/11.
//  Copyright (c) 2015年 Caixi.Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequstSuccessBlock)(id success);
typedef void (^RequstFailureBlock)(NSError *error);

@interface HttpManager : NSObject

+ (HttpManager *)sharedManager;

/**
 *  GET请求
 *
 *  @param URLString 请求路径
 *  @param success   请求成功回调
 *  @param failure   请求失败回调
 */
- (void)GET:(NSString *)URLString
    success:(RequstSuccessBlock)success
    failure:(RequstFailureBlock)failure;

/**
 *  POST请求
 *
 *  @param URLString 请求路径（拼接在BaseURL后面）
 *  @param parame    请求参数
 *  @param success   请求成功回调
 *  @param failure   请求失败回调
 */
- (void)POST:(NSString *)URLString
      parame:(NSDictionary *)parame
      sucess:(RequstSuccessBlock)success
     failure:(RequstFailureBlock)failure;

@end

