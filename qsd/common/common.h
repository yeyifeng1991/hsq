//
//  common.h
//  QiMu
//
//  Created by XH on 16/11/17.
//  Copyright © 2016年 XH. All rights reserved.
//

#ifndef common_h
#define common_h

/** APP版本号 */
#define XHAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** APP BUILD 版本号 */
#define XHAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/** App  项目名称 */
#define XHBundleName     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
/** APP名字 */
#define XHAppDisplayName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
/** 当前语言 */
#define XHLocalLanguage [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]
/** 当前国家 */
#define XHLocalCountry [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]
/*沙盒路径*/
#define DOCPATH          NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
//获取屏幕 宽度、高度
#define imgWidth ([UIScreen mainScreen].bounds.size.width-30-20)/3 //高宽相等
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH (SCREEN_BOUNDS.size.width)
#define SCREEN_HEIGHT (SCREEN_BOUNDS.size.height)
#define SCALE (SCREEN_WIDTH/375)
//通知
#define XHNotificationCenter [NSNotificationCenter defaultCenter]
//plist
#define XHDefault [NSUserDefaults standardUserDefaults]

#pragma - mark - 颜色

#define XHRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XHColor(colorValue) [UIColor colorWithRed:((float)((colorValue & 0xFF0000) >> 16)) / 255.0 green:((float)((colorValue & 0xFF00) >> 8)) / 255.0 blue:((float)(colorValue & 0xFF)) / 255.0 alpha:1.0]

/**
 *  颜色设置宏定义区
 */
#define CCXCGColorWithHexAndAlpha(hex,alpha) [[UIColor colorWithHexString:hex alpha:alpha] CGcolor];
#define CCXColorWithHexAndAlpha(hex,alpha) [UIColor colorWithHexString:hex alpha:alpha]; //通过16进制和透明度设置颜色
#define CCXCGColorWithHex(hex) [[UIColor colorWithHexString:hex] CGColor];
#define CCXColorWithHex(hex) [UIColor colorWithHexString:hex];//通过16进制设置颜色
#define CCXBackColor CCXColorWithHex(@"#f0eff5")//背景色
#define CCXMainColor CCXColorWithHex(GJJMainColorString)//主色调
#define GJJNavigationColor CCXColorWithHex(GJJBlackTextColorString)//导航栏
#define GJJMainColorString @"ffdb01"
#define GJJBlackTextColorString @"3b3a3e"
#define GJJOrangeTextColorString @"feb531"
#define CCXColorWithRBBA(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]//通过R,G,B,A设置颜色
#define CCXColorWithRGB(r,g,b)  [UIColor colorWithRed:r green:g blue:b alpha:1.0f]//通过R,G,B设置颜色

#define button_red XHColor(0xf41515)
#pragma - mark -  字体格式
#define XHFont(ff) [UIFont fontWithName:@"STHeitiSC-Light" size:ff]
#pragma - mark - 间距

#define CELL_HEIGHT 44
#define orderRecord 75*SCALE // 订单记录的单元格高度

#define ACCOUNT    @"accunt" // 用来处理账号异常的判断
#define AccountError @"您的账户异常" //账户异常提醒的字符
#define CHANNELID @"channelId" //手机channelId
#define ordercode @"orderCode" //订单号的code


#define DocumentDirectory  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define CachesDirectory    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define Html5FilesCaches   [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Html5Files"]

#define BaseUrl     @"http://firstapp.weilianup.com/api/" // HOST
#define GetArticleList @"Bussiness/GetArticleList"  //获取文章列表
#define GetAppConfig @"System/GetAppStartConfig"  //获取app信息列表
#define GetAdList    @"System/GetAdList"  //获取广告业列表
#define ViewArticle  @"Bussiness/ViewArticle"  //获取详情

// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能
#define PBLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define PBLog(...)
#endif

//RGB色彩模式
#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//判断当前机型是否为iPhone5
#define IS_IPHONE5() ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)// 是否是iphone5

//判断当前系统是否为iOS7
#define IOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define JCAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])   // 系统的AppleDelegate


//状态栏高度
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

//导航栏高度
#define NAVIGATION_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)

//tabBar高度
#define TABBAR_HEIGHT (STATUSBAR_HEIGHT > 20 ? 83 : 49)

#define SafeAreaBottomHeight (STATUSBAR_HEIGHT > 20 ? 34 : 0)

//适配比例
#define PROPORTION (([UIScreen mainScreen].bounds.size.width) / 375)
#define PROPORTION_H (([UIScreen mainScreen].bounds.size.height) / 667)

// 根据屏幕宽度适配宽度,参数a是在iphone 6(即375宽度)情况下的宽
#define AdaptationWidth(a) ceilf(a * (SCREEN_WIDTH / 375))
// 根据屏幕宽度适配高度,参数a是在iphone 6(即667高度)情况下的高
#define AdaptationHeight(a) ceilf(a * (SCREEN_HEIGHT / 667))

#pragma mark - 常用代码，需求简单，不必要创建基类
//初始化imageView
#define KBACKGROUNDVIEW(name) [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];

//label设置
#define LabelSet(_NAME_, _TEXT_, _TEXTCOLOR_, _FONT_)\
(_NAME_).text = (_TEXT_);\
(_NAME_).textColor = (_TEXTCOLOR_);\
(_NAME_).font = [UIFont systemFontOfSize:(_FONT_)];\
[(_NAME_) sizeToFit];

#endif /* common_h */
