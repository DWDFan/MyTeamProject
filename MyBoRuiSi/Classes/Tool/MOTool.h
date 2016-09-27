//
//  MOTool.h
//  MOTextField
//
//  Created by 莫业金 on 16/3/20.
//  Copyright © 2016年 莫业金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOTool : NSObject
/**
 在宽度一定的情况下返回一个适合的高度
 */
+ (CGFloat)MOtextSizeH:(NSString *)text WithWidth:(CGFloat)width WithFount:(UIFont *)fount;
/**
 *  在高度一定的情况下返回一个适合的宽度
 */
+ (CGFloat)MOtextSizeW:(NSString *)text WithHigth:(CGFloat)width WithFount:(UIFont *)fount;
/**
 *  把控件切圆
 *
 *  @param radius     圆的号数
 *  @param borderWith 边框的宽度
 *  @param boderColor 边框颜色
 *  @param dealView   要切圆的view
 */
+ (void)MODealWithRadius:(CGFloat)radius border:(CGFloat)borderWith borderColor:(UIColor *)boderColor view:(UIView *)dealView;
/**
 *  把时间转换成 刚刚。昨天，等白文
 *
 *  @param time 时间戳
 *
 *  @return 白文
 */
+ (NSString *)timeSwitchShow:(NSString *)time;
/**
 *  比较两个时间的大小
 */
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *)compareCurrentTime:(NSDate*)compareDate;

/**
 *  对一张图片进行中间点伸缩
 *
 *  @param origingImage 原始图片
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)imageWithCetnerPoint:(NSString *)origingImageName;
/**
 *  获取当前时间戳
 */
+ (NSString *)GetCurrentTimeStamp;

//MARK:/*时间戳转时间 */
+ (NSString *)timeStampToString:(NSString *)timeStamp;

/**
 *  表情转换
 *
 */
+(NSString *)creatMASWithString:(NSString *)str ;



+(UIImage*) createImageWithColor:(UIColor*) color;

/**
 *  添加导航栏右边按钮
 *
 */
+ (UIBarButtonItem *)addRightItemWithImage:(NSString *)imageName action:(SEL)action typeClass:(id)type;

/**
 *  判断只输入空格
 *
 */
+(BOOL)isEmpty:(NSString *) str;


//时间转换
+ (NSString *)timeFormatted:(long long)totalSeconds;

//
+ (NSString *)timeFormattedTwo:(long long)totalSeconds;

/**
 *  根据字体返回Size
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;

+ (NSString *)getNULLString:(NSObject *)obj;


- (UIImage*) createImageWithColor: (UIColor*) color;
@end
