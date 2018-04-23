//
//  ArticleListModel.h
//  qsd
//
//  Created by mc on 2018/4/21.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleListModel : NSObject
//"Id": "int",
//"ArticleName": "",
//"ArticleType": "",
//"Icon": "",
//"ReadCount": "int",
//"TopicUrl": "",
//"AppTopicUrl": "",
//"ArticleContent": "",
//"Author": "",
//"Source": "",
//"KeyWords": "",
//"CreateTime": "Date",
//"IsDujia": false,
//"Status": false,
//"IconSrc": "",
//"PublishTime": ""
@property (nonatomic,strong) NSString*id ;
@property (nonatomic,strong) NSString*articleName ;
@property (nonatomic,strong) NSString*articleType ;
@property (nonatomic,strong) NSString*icon ;
@property (nonatomic,strong) NSString*readCount ;
@property (nonatomic,strong) NSString*topicUrl ;
@property (nonatomic,strong) NSString*appTopicUrl;
@property (nonatomic,strong) NSString*articleContent;
@property (nonatomic,strong) NSString*author;
@property (nonatomic,strong) NSString*source;
@property (nonatomic,strong) NSString*keyWords;//
@property (nonatomic,strong) NSString*createTime;//
@property (nonatomic,assign) BOOL isDujia;//
@property (nonatomic,assign) BOOL status;//
@property (nonatomic,strong) NSString*iconSrc;// 图片路径
@property (nonatomic,strong) NSString*publishTime;//
@end
