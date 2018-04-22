//
//  XYHttpManager.h
//  单列讲解
//
//  Created by YeYiFeng on 2018/3/21.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YZSingletonH.h"
@class XYHttpManager;


//block回调传值
/**
 *   请求成功回调json数据
 *
 *  @param json json串
 */
typedef void(^Success)(id json);
typedef void(^Failure)(NSError *error);
@interface XYHttpManager : NSObject
#pragma mark - 单例的全局使用
//YZSingletonH(XYHttpManager);
//单例模式
+ (XYHttpManager *)manager;

/**
 GET请求
 
 @param url url
 @param paramters 参数
 @param success suc回调
 @param failure fail回调
 */
- (void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure;

/**
 POST请求 json类型
 
 @param url url
 @param paramters 参数
 @param success suc
 @param failure fail
 */
- (void)postJsonDataWithUrl:(NSString *)url
                 parameters:(NSDictionary *)paramters
                    success:(Success)success
                    failure:(Failure)failure;

/**
 *  POST请求 Form数据
 *
 *  @param url       NSString 请求url
 *  @param paramters NSDictionary 参数
 *  @param success   void(^Success)(id json)回调
 */
- (void)postDataWithUrl:(NSString *)url
             parameters:(NSDictionary *)paramters
                success:(Success)success
                failure:(Failure)failure;


/**
 *  3.上传文件
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param data       上传的文件
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)uploadFileWithURL:(NSString*)URLString
               parameters:(NSDictionary*)parameters
               uploadData:(NSData *)data
                  success:(Success)success
                  failure:(Failure)failure;

@end
