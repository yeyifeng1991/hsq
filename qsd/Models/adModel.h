//
//  adModel.h
//  qsd
//
//  Created by mc on 2018/4/21.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adModel : NSObject

/*
 "id": 33,
 "adPosition": "资讯详情",
 "adDesc": null,
 "adPicUrl": "http://m.money.hzcailanzi.cn/images/h5_banner_ad1.png",
 "adHref": "#",
 "adAppType": "app",
 "articleType": "对话专家",
 "sortId": 1,
 "isOpen": true
 */
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *adPosition;
@property (nonatomic,strong) NSString *adDesc;
@property (nonatomic,strong) NSString *adPicUrl; //广告图片地址
@property (nonatomic,strong) NSString *adHref;
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) NSString *articleType;

@end
