//
//  ArticleModel.h
//  qsd
//
//  Created by mc on 2018/4/21.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
/*
 "id": 8,
 "articleName": "用户急用钱心理成骗子“利器”，贷款骗局升级",
 "articleType": "借贷热点",
 "icon": "20103349yysl.png,/Upload/Project/2018042111332312-20103349yysl.png",
 "readCount": 365411,
 "topicUrl": null,
 "appTopicUrl": null,
 "articleContent": "<div class=\"content-txt\">\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t网上无门槛贷款，大多是骗局，江苏省反通讯网络诈骗中心（以下简称“省反诈骗中心”）此前已经曝光过多次，但最近这一骗局再次升级，套路更深。无锡市民杨先生明明已经拿到了打到自己银行卡上的贷款，但最后还是发红包把这3.2万元“还”给了骗子。4月19日，省反诈骗中心就此发出了警示。\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>[警情快报]</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>网贷收到钱</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>居然发红包“还”给骗子</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t今年4月1日上午，无锡市民杨先生接到一陌生女子电话，对方自称可以提供贷款服务。杨先生正好需要钱，就加了对方微信好友。双方商量好借款额度后，对方就发了一张个人信息表给杨先生。杨先生填写了自己的银行卡号、身份证号、目前拥有的周转资金等信息，然后回传。\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t4月5日上午10点左右，杨先生再次接到那名陌生女子电话，对方称他申请的贷款已经办好，但是需要银行卡内有贷款金额的40%作为还款能力的证明。杨先生相信了对方，在自己的银行卡内存入3.2万元。之后，杨先生手机上收到银行的验证码，对方要求提供，他就给了，结果发现银行卡内被扣款3.2万元。杨先生当即询问对方怎么回事，对方称这笔钱会和贷款一起发下来，杨先生没有起疑。\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t果然，之后杨先生的银行卡陆续收到钱，总额为3.22万元。但对方表示，因为要避税，所以这些钱要从微信群里过一下。杨先生便按照对方要求扫了个二维码进了一个微信群，并听从对方指示，在微信群内将银行卡内收到的钱全都发红包发掉了。钱发完后，杨先生才意识到有点不对。他再次联系对方，对方已经将其拉黑。这时，杨先生才意识到被骗，赶紧报警。\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>【骗术揭秘】</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>无门槛<a href=\"http://www.wdtianxia.com/\" target=\"_blank\">网贷</a>是幌子</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>骗取银行卡信息是真</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t省反诈骗中心相关负责人表示，杨先生遭遇的是典型的网上无门槛贷款骗局。骗子抓住人们急于用钱的心理，抛出无抵押贷款幌子，通过打电话、发送短信或网上发布虚假信息“海选”受害人。受害人与其联系后，犯罪嫌疑人往往以先收手续费再放款为理由骗取钱财。\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t“在杨先生遭遇的骗局中，骗子以贷款为幌子，骗取了他的银行卡信息。”上述负责人说，对方在获取杨先生的短信验证码后，便将其卡内的资金骗走。而之后杨先生卡上收到钱，则是对方的迷惑手段。对方用的钱就是杨先生被骗的钱，而且这些钱最终都回到了骗子手中。\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>【防范贴士】</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<strong>网上无门槛贷款大多是骗局</strong>\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t<br />\r\n\t</p>\r\n\t<p style=\"text-indent:2em;\">\r\n\t\t针对此类骗局，省反诈骗中心提醒广大市民，网上无门槛贷款大多是骗局，贷款是有一些限制条件的，没有无门槛的说法。有贷款需求的市民应当选择正规的具备相应资质的金融机构办理贷款，切莫相信“网络借贷”电话的“三分钟到账”等说辞。遇到对方要求交付“保证金”“周转金”“解冻账户资金”等说法时，一定要保持警惕，不可轻易转账。\r\n\t</p>\r\n\t<p>\r\n\t\t<br />\r\n\t</p>\r\n</div>",
 "author": "网贷",
 "source": "网贷天下",
 "keyWords": null,
 "createTime": "/Date(1524281615503-0000)/",
 "isDujia": false,
 "status": true,
 "iconSrc": "/Upload/Project/2018042111332312-20103349yysl.png",
 "publishTime": "4小时前"
 */
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *articleName;
@property (nonatomic,strong) NSString *articleType; //借贷热点 用来传相关信息
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *readCount;
@property (nonatomic,strong) NSString *topicUrl;
@property (nonatomic,strong) NSString *appTopicUrl;
@property (nonatomic,strong) NSString *articleContent;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *source;
@property (nonatomic,strong) NSString *keyWords;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,assign) BOOL isDujia; // 是否独家
@property (nonatomic,assign)BOOL status;
@property (nonatomic,strong) NSString *iconSrc;
@property (nonatomic,strong) NSString *publishTime;

@end
