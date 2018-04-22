//
//  AppStartConfigModel.h
//  qsd
//
//  Created by mc on 2018/4/21.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStartConfigModel : NSObject
/*
 "id": 2,
"key": "SysConfig",
"value": "True",
"url": "http://meimei.weilianupup.com/",
"remark": ""
 */
@property (nonatomic,strong) NSString * id;
@property (nonatomic,strong) NSString * key;
@property (nonatomic,strong) NSString * value;
@property (nonatomic,strong) NSString * url;
@property (nonatomic,strong) NSString * remark;
@end
