//
//  AppTools.m
//  Picturebooks
//
//  Created by 尹凯 on 2017/7/18.
//  Copyright © 2017年 ZhiyuanNetwork. All rights reserved.
//

#import "AppTools.h"
#import "AppDelegate.h"

@implementation AppTools

//+ (CGFloat)heightForContent:(NSString *)content fontOfText:(CGFloat)textFont spacingOfLabel:(CGFloat)spacing{
//    CGSize size = CGSizeMake(SCREEN_WIDTH - spacing * 2, 10000);
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:textFont], NSFontAttributeName, nil];
//    CGRect frame = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
//    return frame.size.height + 0.252;
//}

+ (CGFloat)heightForAttributeContent:(NSString *)content fontoOfText:(CGFloat)textFont width:(CGFloat)width lineSpace:(CGFloat)lineSpace{
    CGSize size = CGSizeMake(width, 10000);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:textFont], NSFontAttributeName, paragraphStyle, NSParagraphStyleAttributeName, nil];
    CGRect frame = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return frame.size.height;
}

/**
 *  得到app名称
 *
 *  @return app名称
 */
+ (NSString *)getAppName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

/**
 *  得到app版本
 *
 *  @return app版本
 */
+ (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

/**
 *  得到ios系统版本
 *
 *  @return ios系统版本
 */
+ (float)getIOSVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

/**
 *  将给定string转成拼音
 *
 *  @param string 给定的string
 *
 *  @return 转换的拼音
 */
+ (NSString*)transformToPinyin:(NSString *)string{
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)mutableString,NULL,kCFStringTransformToLatin,false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString;
}

/**
 *  判断给定string是否为整数
 *
 *  @param string 给定的string
 *
 *  @return 整数返回真
 */
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  判断给定string是否为浮点数
 *
 *  @param string 给定的string
 *
 *  @return 浮点数数返回真
 */
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  判断给定string是否为电话号
 *
 *  @param string 给定的string
 *
 *  @return 不是电话号返回真
 */
+ (BOOL)isNotPhoneNumber:(NSString *)string{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:string] == YES))
    {
        return NO;
    }
    else
    {
        [self showToastWithText:@"手机号填写有误"];
        return YES;
    }
}

//判断是否为中文名
+ (BOOL)isNotName:(NSString *)string
{
    for(int i=0; i< [string length];i++)
    {
        int a = [string characterAtIndex:i];
        //有英文
        if( a <= 0x4e00 || a >= 0x9fff)
        {
            [AppTools showToastWithText:@"请输入正确的姓名"];
            return YES;
        }
    }
    if (string.length<2 || string.length>8)
    {
        [AppTools showToastWithText:@"请输入正确的姓名"];
        return YES;
    }
    return NO;
}

/**
 *  判断给定string是否为身份证
 *
 *  @param string 给定的string
 *
 *  @return 不是身份证返回真
 */
+ (BOOL)isNotIDCard:(NSString *)string
{
    if (string.length <= 0)
    {
        [AppTools showToastWithText:@"身份证号填写有误"];
        return YES;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if ([identityCardPredicate evaluateWithObject:string])
    {
        return NO;
    }
    [AppTools showToastWithText:@"身份证号填写有误"];
    return YES;
}

/**
 *  判断给定string是否为邮箱
 *
 *  @param string 给定的string
 *
 *  @return 不是邮箱返回真
 */
+ (BOOL)isNotEmail:(NSString *)string
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:string])
    {
        return NO;
    }
    else
    {
        [AppTools showToastWithText:@"邮箱填写有误"];
        return YES;
    }
}

/**
 *  判断给定string是否为空
 *
 *  @param string 给定的string
 *  @param name 判断的名字
 *
 *  @return 是空返回真
 */
+ (BOOL)isEmpty:(NSString *)string name:(NSString *)name
{
    if ([[string stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
    {
        [self showToastWithText:[NSString stringWithFormat:@"%@不能为空哦",name]];
        return YES;
    }
    return NO;
}

/**
 *  判断给定string是否过长
 *
 *  @param string    给定的string
 *  @param maxLength 最大长度
 *  @param name      判断的名字
 *
 *  @return 过长返回真
 */
+ (BOOL)isTooLong:(NSString *)string maxLength:(NSInteger)maxLength name:(NSString *)name
{
    if (string.length > maxLength)
    {
        [self showToastWithText:[NSString stringWithFormat:@"%@最多%ld个字哦",name,(long)maxLength]];
        return YES;
    }
    return NO;
}

/**
 *  判断给定string是否过短
 *
 *  @param string    给定的string
 *  @param minLength 最小长度
 *  @param name      判断的名字
 *
 *  @return 过短返回真
 */
+ (BOOL)isTooShort:(NSString *)string minLength:(NSInteger)minLength name:(NSString *)name
{
    if (string.length < minLength)
    {
        [self showToastWithText:[NSString stringWithFormat:@"%@最少%ld个字哦",name,(long)minLength]];
        return YES;
    }
    return NO;
}

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
+ (BOOL)isVerifiedWithText:(NSString *)string name:(NSString *)name maxLength:(NSInteger)maxLength minLength:(NSInteger)minLength shouldEmpty:(BOOL)empty
{
    if (!empty)
    {
        if ([AppTools isEmpty:string name:name])
        {
            return NO;
        }
    }
    
    if ([AppTools isTooLong:string maxLength:maxLength name:name])
    {
        return NO;
    }
    
    if ([AppTools isTooShort:string minLength:minLength name:name])
    {
        return NO;
    }
    return YES;
}

/**
 *  创建statusBar上的toast
 *
 *  @param text 要显示的文字
 */
+(void)showToastWithText:(NSString *)text
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:JCAppDelegate.window animated:YES];
//    hud.backgroundColor = [UIColor clearColor];
//    hud.mode = MBProgressHUDModeText;
//    //是否有遮罩
//    hud.dimBackground = NO;;
//    hud.labelText = text;
//    hud.animationType = MBProgressHUDAnimationZoomIn;
//    hud.removeFromSuperViewOnHide = YES;
//    hud.userInteractionEnabled = NO;
//    [hud hide:YES afterDelay:2];
}

/**
 *  将int快速转为string
 *
 *  @param value 要转换的int
 *
 *  @return 返回的string
 */
+ (NSString *)stringValueWithInt:(int)value
{
    return [NSString stringWithFormat:@"%d",value];
}

//获取当前时间
+ (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //----------设置你想要的格式，hh与HH的区别：分别表示12小时制，24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //当前时间
    NSDate *dateNow = [NSDate date];
    //----------将NSDate按formatter格式转成NSString
    NSString *currentTimeString = [formatter stringFromDate:dateNow];
    return currentTimeString;
}

//时间戳转换成时间字符串
+ (NSString *)timestampToTimeChinese:(NSString *)timestamp{
    //时间戳转换成date
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue / 1000];
    //设置时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //转换成NSString
    return [[[[formatter stringFromDate:date] stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"] stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"] stringByAppendingString:@"日"];
}

//时间戳转换成时间字符串
+ (NSString *)timestampToTime:(NSString *)timestamp format:(NSString *)format{
    //时间戳转换成date
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue / 1000];
    //设置时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    //转换成NSString
    return [formatter stringFromDate:date];
}

//秒转换成分和秒
+ (NSString *)secondsToMinutesAndSeconds:(NSString *)secondsStr{
    NSInteger seconds = [secondsStr integerValue];
    //重新计算
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (long)seconds/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld", (long)seconds%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@'%@\"", str_minute, str_second];
    return format_time;
}

+ (NSString *)secondsToMinutesAndSecondsI:(NSString *)secondsStr{
    NSInteger seconds = [secondsStr integerValue];
    //重新计算
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (long)seconds/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld", (long)seconds%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
    return format_time;
}

+ (NSString *)getTimestamp{
    //获取当前时间戳
    NSDate *senddate = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    return timestamp;
}

+ (NSString *)getTimestamp13{
    //获取当前时间戳
    NSDate *senddate = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)([senddate timeIntervalSince1970] * 1000)];
    return timestamp;
}
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
