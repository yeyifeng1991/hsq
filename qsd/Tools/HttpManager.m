//
//  HttpManager.h
//
//  Created by zcx on 15/3/11.
//  Copyright (c) 2015年 Caixi.Zheng. All rights reserved.
//

#import "HttpManager.h"
#import "AFHttpSessionManager.h"
#import <CommonCrypto/CommonCrypto.h>

//#define DEV // 开发环境
//#define TEST // 测试部测试环境
#define RELEASE // 上架生产环境

// 开发环境
#ifdef DEV
#define language = "English"
#define URL_API_DOMAIN @"http://firstapp.weilianup.com/api/"
#endif

// 测试部测试环境
#ifdef TEST
#define language = "英文"
#define URL_API_DOMAIN @"http://firstapp.weilianup.com/api/"
#endif

// 上架生产环境
#ifdef RELEASE
#define URL_API_DOMAIN @"http://firstapp.weilianup.com/api/"
#endif

#define kIsNull(x) (!x || [x isKindOfClass:[NSNull class]])
#define kRequstUrl(url) [NSString stringWithFormat:@"%@%@",URL_API_DOMAIN,url]
#define kBlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil;

static NSTimeInterval kTimeoutInterval = 10.f;
@interface HttpManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation HttpManager

static HttpManager *_instance;
+ (HttpManager *)sharedManager{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _instance = [[HttpManager alloc] init];
    });
    return _instance;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        
        //AFJSONRequestSerializer
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 超时时间
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sessionManager.requestSerializer.timeoutInterval = kTimeoutInterval;
        [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        //AFHTTPResponseSerializer
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];

//        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    return _sessionManager;
}

#pragma mark - GET请求
- (void)GET:(NSString *)URLString
    success:(RequstSuccessBlock)success
    failure:(RequstFailureBlock)failure
{
    NSString *path = [URLString hasPrefix:@"http"] ? URLString : kRequstUrl(URLString);

//    path = [path stringByAppendingString:@"&format=json"];
    //在 iOS 程序访问 HTTP 资源时需要对 URL 进行 Encode，比如像拼出来的http://m.money.hzcailanzi.cn:80/api/Bussiness/GetLoanProjectList?LoanType=快速微额贷&Limit=10&Offset=0，其中的中文、特殊符号&％和空格都必须进行转译才能正确访问
    NSString *urlEncode = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.sessionManager GET:urlEncode parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        success(responseDictionary);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - POST请求
- (void)POST:(NSString *)URLString
      parame:(NSDictionary *)parame
      sucess:(RequstSuccessBlock)success
     failure:(RequstFailureBlock)failure
{
    NSString *path = [URLString hasPrefix:@"http"] ? URLString : kRequstUrl(URLString);
    
    [self.sessionManager POST:path parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *responseString = [str stringByReplacingOccurrencesOfString:@"  " withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if (responseDictionary == NULL) {
            BOOL saveApplyLog = (BOOL)responseObject;
            success([NSString stringWithFormat:@"%d", saveApplyLog]);
        }else{
            success(responseDictionary);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
