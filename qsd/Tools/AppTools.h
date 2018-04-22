//
//  AppTools.h
//  Picturebooks
//
//  Created by 尹凯 on 2017/7/18.
//  Copyright © 2017年 ZhiyuanNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppTools : NSObject

/**
 根据文本内容、字体大小、左右间距返回一个高度
 
 @param content 文本内容
 @param textFont 字体大小
 @param spacing 文本框左右间距
 @return 文本框高度
 */
+ (CGFloat)heightForContent:(NSString *)content fontOfText:(CGFloat)textFont spacingOfLabel:(CGFloat)spacing;

/**
 根据富文本属性返回一个高度
 
 @param content 文本内容
 @param textFont 字体
 @param width 宽度
 @param lineSpace 行间距
 @return 高度
 */
+ (CGFloat)heightForAttributeContent:(NSString *)content fontoOfText:(CGFloat)textFont width:(CGFloat)width lineSpace:(CGFloat)lineSpace;

/**
 *  得到app名称
 *
 *  @return app名称
 */
+ (NSString *)getAppName;

/**
 *  得到app版本
 *
 *  @return app版本
 */
+ (NSString *)getAppVersion;

/**
 *  得到ios系统版本
 *
 *  @return ios系统版本
 */
+ (float)getIOSVersion;

/**
 *  将给定string转成拼音
 *
 *  @param string 给定的string
 *
 *  @return 转换的拼音
 */
+ (NSString*)transformToPinyin:(NSString *)string;

/**
 *  判断给定string是否为整数
 *
 *  @param string 给定的string
 *
 *  @return 整数返回真
 */
+ (BOOL)isPureInt:(NSString*)string;

/**
 *  判断给定string是否为浮点数
 *
 *  @param string 给定的string
 *
 *  @return 浮点数数返回真
 */
+ (BOOL)isPureFloat:(NSString*)string;

/**
 *  判断给定string是否为电话号
 *
 *  @param string 给定的string
 *
 *  @return 不是电话号返回真
 */
+ (BOOL)isNotPhoneNumber:(NSString *)string;

/**
 *  判断是否为中文名
 *
 *  @param string 给定的字符串
 *  @return 不是中文名返回真
 */
+ (BOOL)isNotName:(NSString *)string;

/**
 *  判断给定string是否为身份证
 *
 *  @param string 给定的string
 *
 *  @return 不是身份证返回真
 */
+ (BOOL)isNotIDCard:(NSString *)string;

/**
 *  判断给定string是否为邮箱
 *
 *  @param string 给定的string
 *
 *  @return 不是邮箱返回真
 */
+ (BOOL)isNotEmail:(NSString *)string;

/**
 *  判断给定string是否为空
 *
 *  @param string 给定的string
 *  @param name 判断的名字
 *
 *  @return 是空返回真
 */
+ (BOOL)isEmpty:(NSString *)string name:(NSString *)name;

/**
 *  判断给定string是否过长
 *
 *  @param string    给定的string
 *  @param maxLength 最大长度
 *  @param name      判断的名字
 *
 *  @return 过长返回真
 */
+ (BOOL)isTooLong:(NSString *)string maxLength:(NSInteger)maxLength name:(NSString *)name;

/**
 *  判断给定string是否过短
 *
 *  @param string    给定的string
 *  @param minLength 最小长度
 *  @param name      判断的名字
 *
 *  @return 过短返回真
 */
+ (BOOL)isTooShort:(NSString *)string minLength:(NSInteger)minLength name:(NSString *)name;

/**
 *  判断给定string是否合法
 *
 *  @param string    给定的string
 *  @param name      判断的名字
 *  @param maxLength 最大长度
 *  @param minLength 最小长度
 *  @param empty     是否可以为空
 *
 *  @return 合法返回真
 */
+ (BOOL)isVerifiedWithText:(NSString *)string name:(NSString *)name maxLength:(NSInteger)maxLength minLength:(NSInteger)minLength shouldEmpty:(BOOL)empty;

/**
 *  创建statusBar上的toast
 *
 *  @param text 要显示的文字
 */
+ (void)showToastWithText:(NSString *)text;

/**
 *  将int快速转为string
 *
 *  @param value 要转换的int
 *
 *  @return 返回的string
 */
+ (NSString *)stringValueWithInt:(int)value;

//获取当前时间
+ (NSString *)getCurrentTime;

//时间戳转换成时间字符串
+ (NSString *)timestampToTimeChinese:(NSString *)timestamp;
+ (NSString *)timestampToTime:(NSString *)timestamp format:(NSString *)format;

//秒转换成分和秒
+ (NSString *)secondsToMinutesAndSeconds:(NSString *)secondsStr;
//秒转换成分和秒
+ (NSString *)secondsToMinutesAndSecondsI:(NSString *)secondsStr;

//获取当前时间戳
+ (NSString *)getTimestamp;//获取10位时间戳
+ (NSString *)getTimestamp13;//获取13位时间戳
//图片压缩
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage;
@end
