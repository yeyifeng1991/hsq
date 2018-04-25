//
//  titleModel.h
//  qsd
//
//  Created by mc on 2018/4/25.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface titleModel : NSObject
/*
 key = 1;
 value = 借贷热点;
 href = #;
 */
@property (nonatomic,strong) NSString * key; //
@property (nonatomic,strong) NSString * value; // 标题名称
@property (nonatomic,strong) NSString * href;
@end
