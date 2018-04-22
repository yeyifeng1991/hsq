//
//  ArticleListModel.h
//  qsd
//
//  Created by mc on 2018/4/21.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleListModel : NSObject
//id = 1;
//publishTime = 20小时前;
//topicUrl = <null>;
//author = 鹰眼区块链团队;
//appTopicUrl = <null>;
//source = 鹰眼区块链;
//articleContent
@property (nonatomic,strong) NSString*id ;
@property (nonatomic,strong) NSString*publishTime ; // 发布时间
@property (nonatomic,strong) NSString*topicUrl ; // 顶部链接
@property (nonatomic,strong) NSString*author ; //作者
@property (nonatomic,strong) NSString*appTopicUrl ;
@property (nonatomic,strong) NSString*source ;// 来源
@property (nonatomic,strong) NSString*articleContent;// 文章内容
@end
