//
//  XYHttpManager.m
//  单列讲解
//
//  Created by YeYiFeng on 2018/3/21.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "XYHttpManager.h"
#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>
//#import "YZSingletonH.h"
static XYHttpManager *_instance = nil;
static AFHTTPSessionManager *afnManager = nil;
static NSString * const BaseUrl = @"http://";
@implementation XYHttpManager
//YZSingletonM(XYHttpManager);
/**
 *  创建单例
 *
 *  @return nil
 */
+ (id)allocWithZone:(struct _NSZone *)zone
{
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}
+ (XYHttpManager *)manager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XYHttpManager alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        afnManager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _instance;
}
//GET请求
- (void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure; {
    afnManager.requestSerializer=[AFHTTPRequestSerializer serializer];
    afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
   [afnManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    afnManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    NSLog(@"%@",[url stringByAppendingString:@"&format=json"]);
    [afnManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonStr  =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
//POST请求 json类型
- (void)postJsonDataWithUrl:(NSString *)url
                 parameters:(NSDictionary *)paramters
                    success:(Success)success
                    failure:(Failure)failure; {
    
    NSError *error;
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl, url];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    
    req.timeoutInterval = 30.f;
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString *jsonString = nil;
    
    if (paramters) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramters options:0 error:&error];
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            
            NSDictionary *dict = responseObject;
            if ([dict[@"code"] integerValue] == 200 || [dict[@"code"] integerValue] == 0) {
                success(dict);
            }  else if ([dict[@"code"] integerValue] == 901 ) {
                /*
                 [SVProgressHUD dismiss];
                 //异地登录
                 
                 [DJAlertView showAlerViewControllerWithVC:[UIApplication sharedApplication].keyWindow.rootViewController Title:@"下线通知" Message:dict[@"message"] CancelTitle:nil EnsureTitle:@"确定" CancelBlock:nil EnsureBlock:^{
                 
                 [SystemTools logout];
                 
                 }];
                 
                 
                 */
            } else {
                /*
                 NSString *msg = dict[@"message"]?dict[@"message"]:@"错误信息";
                 NSInteger code = [dict[@"code"] integerValue];
                 [SVProgressHUD showErrorWithStatus:msg];
                 [weakSelf performSelector:@selector(dissmiss) withObject:nil afterDelay:2];
                 failure([NSError errorWithDomain:@"service error" code:code userInfo:@{@"error describe":msg}]);
                 */
                
            }
            
        } else {
            /*
             
             [SVProgressHUD showErrorWithStatus:@"系统开小差了呢，请稍后再试"];
             [weakSelf performSelector:@selector(dissmiss) withObject:nil afterDelay:2];
             failure(error);
             */
            
        }
        
    }] resume];
    
}

//POST请求 form表单数据 类型
- (void)postDataWithUrl:(NSString *)url
             parameters:(NSDictionary *)paramters
                success:(Success)success
                failure:(Failure)failure;
{
    //      __weak typeof(self) weakSelf = self;
    
    afnManager.requestSerializer=[AFHTTPRequestSerializer serializer];
    afnManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"json/text", @"text/json",@"application/json",@"text/javascript",nil];
    
    afnManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl, url];
    
    [afnManager POST:urlString parameters:paramters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        if ([dict[@"code"] integerValue] == 200 || [dict[@"code"] integerValue] == 0) {
            success(dict);
        } else if ([dict[@"code"] integerValue] == 901 ) {
            /*
             [SVProgressHUD dismiss];
             //异地登录
             [DJAlertView showAlerViewControllerWithVC:[UIApplication sharedApplication].keyWindow.rootViewController Title:@"下线通知" Message:dict[@"message"] CancelTitle:nil EnsureTitle:@"确定" CancelBlock:nil EnsureBlock:^{
             [SystemTools logout];
             }];
             */
            
            
        } else {
            /*
             NSString *msg = dict[@"message"]?dict[@"message"]:@"错误信息";
             NSInteger code = [dict[@"code"] integerValue];
             [SVProgressHUD showErrorWithStatus:msg];
             [weakSelf performSelector:@selector(dissmiss) withObject:nil afterDelay:2];
             failure([NSError errorWithDomain:@"service error" code:code userInfo:@{@"error describe":msg}]);
             
             */
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /*
         [SVProgressHUD showErrorWithStatus:@"系统开小差了呢，请稍后再试"];
         [weakSelf performSelector:@selector(dissmiss) withObject:nil afterDelay:2];
         */
        
        failure(error);
        
    }];
}

/*
 -(void)dissmiss
 {
 [SVProgressHUD dismiss];
 }
 */

// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    if (!dict) {
        return nil;
    }
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

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
                  failure:(Failure)failure{
    
    
    afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [afnManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /*
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *dateStr = [formatter stringFromDate:[NSDate date]];
         NSString *fileName = [NSString stringWithFormat:@"%@.png",dateStr];
         
         [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
         */
        [formData appendPartWithFileData:data name:@"header" fileName:@"header.png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功，解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        
        if ([dict[@"code"] integerValue] == 200 || [dict[@"code"] integerValue] == 0) {
            success(dict);
        } else if ([dict[@"code"] integerValue] == 901 ) {
            /*
             [SVProgressHUD dismiss];
             //异地登录
             
             [DJAlertView showAlerViewControllerWithVC:[UIApplication sharedApplication].keyWindow.rootViewController Title:@"下线通知" Message:dict[@"message"] CancelTitle:nil EnsureTitle:@"确定" CancelBlock:nil EnsureBlock:^{
             [SystemTools logout];
             }];
             */
            
            
        }  else {
            /*
             NSString *msg = dict[@"message"]?dict[@"message"]:@"错误信息";
             NSInteger code = [dict[@"code"] integerValue];
             [SVProgressHUD showErrorWithStatus:msg];
             [self performSelector:@selector(dissmiss) withObject:nil afterDelay:2];
             
             */
            NSString *msg = dict[@"message"]?dict[@"message"]:@"错误信息";
            NSInteger code = [dict[@"code"] integerValue];
            failure([NSError errorWithDomain:@"service error" code:code userInfo:@{@"error describe":msg}]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /*
         [SVProgressHUD showErrorWithStatus:@"系统开小差了呢，请稍后再试"];
         [self performSelector:@selector(dissmiss) withObject:nil afterDelay:2];
         */
        failure(error);
        
    }];
    
    
}

@end
