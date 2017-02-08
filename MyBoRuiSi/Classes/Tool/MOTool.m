//
//  MOTool.m
//  MOTextField
//
//  Created by 莫业金 on 16/3/20.
//  Copyright © 2016年 莫业金. All rights reserved.
//

#import "MOTool.h"
#import "NSDate+MJ.h"
#import "WLRegisteringViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation MOTool


//MARK: --------------------------------NSString------------------------------
/**
 在宽度一定的情况下返回一个适合的高度
 */
+ (CGFloat)MOtextSizeH:(NSString *)text WithWidth:(CGFloat)width WithFount:(UIFont *)fount
{
    //  去掉字符串中空格
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    if(fount == nil){
        fount = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    CGFloat H = [text sizeWithFont:fount constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:0].height;
//    if (H > 28) {
//        H -= 10;
//    }
    return H;
    
//    if(fount == nil){
//        fount = [UIFont systemFontOfSize:[UIFont systemFontSize]];
//    }
//    
//    //根据字体来获取Label的长度和高度 (ios8之后新方法)
////    NSDictionary *nameDic = @{NSFontAttributeName:[UIFont systemFontSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:82 / 250.0 green:82 / 250.0 blue:82 / 250.0 alpha:1]};
//     NSDictionary *nameDic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:82 / 250.0 green:82 / 250.0 blue:82 / 250.0 alpha:1]};
//    
//    CGSize nameSize = [text boundingRectWithSize:CGSizeMake(MOScreenW - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nameDic context:nil].size;
//    
////    return [text sizeWithFont:fount constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:0].height;
//    return nameSize.height;
}
/**
 *  在高度一定的情况下返回一个适合的宽度
 */
+ (CGFloat)MOtextSizeW:(NSString *)text WithHigth:(CGFloat)height WithFount:(UIFont *)fount
{
//    return [text sizeWithFont:fount constrainedToSize:CGSizeMake(MAXFLOAT, height) lineBreakMode:0].width;
     NSDictionary *nameDic = @{NSFontAttributeName:fount,NSForegroundColorAttributeName:[UIColor colorWithRed:82 / 250.0 green:82 / 250.0 blue:82 / 250.0 alpha:1]};
    CGSize nameSize = [text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nameDic context:nil].size;
    
    //    return [text sizeWithFont:fount constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:0].height;
    return nameSize.width;
}
/**
 *  把控件切圆
 *
 *  @param radius     圆的号数
 *  @param borderWith 边框的宽度
 *  @param boderColor 边框颜色
 *  @param dealView   要切圆的view
 */
+ (void)MODealWithRadius:(CGFloat)radius border:(CGFloat)borderWith borderColor:(UIColor *)borderColor view:(UIView *)dealView{
    
    dealView.layer.cornerRadius = radius;
    dealView.layer.masksToBounds = YES;
    if(borderWith > 0){
        
        dealView.layer.borderWidth = borderWith;
        dealView.layer.borderColor = [borderColor CGColor];
    }
}
+ (NSString *)timeStampToString:(NSString *)timeStamp
{
    
    double timeSta = [timeStamp doubleValue];
    
    NSDateFormatter *form = [[NSDateFormatter alloc]init];
    
    form.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeSta];
    
    NSString *confromTimespStr = [form stringFromDate:confromTimesp];
    
    return confromTimespStr;
}
/**
 *  把时间转换成 刚刚。昨天，等白文
 *
 *  @param time 时间戳
 *
 *  @return 白文
 */
+ (NSString *)timeSwitchShow:(NSString *)time
{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
#warning 真机必须加上这句话，否则转换不成功，必须告诉日期格式的区域，才知道怎么解析
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    // 获取时间
    NSDate *createDate = [fmt dateFromString:time];
    if ([createDate isThisYear]) { // 判断是否今年
        if ([createDate isToday]) { // 今天
            // 获取时间差
            NSDateComponents *cmp =  [createDate deltaWithNow];
            if (cmp.hour >= 1) { // 至少1小时
                return [NSString stringWithFormat:@"%d小时前",(int)cmp.hour];
            }else if (cmp.minute > 1){ // 1~60分钟内发的
                return [NSString stringWithFormat:@"%d分钟前",(int)cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if ([createDate isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
            
        }else{ // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{ // 不是今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}
/**
 *  比较两个时间的大小
 */
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    //WLLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}
/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}




//MARK: --------------------------------UIImage------------------------------
/**
 *  对一张图片进行中间点伸缩
 *
 *  @param origingImage 原始图片
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)imageWithCetnerPoint:(NSString *)origingImageName{
    
    UIImage *image = [UIImage imageNamed:origingImageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
}
/**
 *  获取当前时间戳
 */
+ (NSString *)GetCurrentTimeStamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    return timeString;
}



+(NSString *)creatMASWithString:(NSString *)str {
    
    
    /** 判断是否含有表情符号  处理*/
    NSString *endStr = [NSString string];
    /** 存储图片应该插入的位置*/
    //  NSMutableArray *insertLength = [NSMutableArray array];
    /** 存储图片名字*/
    NSMutableArray *emjArr = [NSMutableArray array];
    
    NSArray *tepArr = [str componentsSeparatedByString:@"</e>"];
    for (int i = 0; i<tepArr.count; i++) {
        NSString *anyStr = tepArr[i];
        if ([anyStr containsString:@"<e>"]) {
            NSRange range = [anyStr rangeOfString:@"<e>"];
            NSString *textStr=[anyStr substringToIndex:range.location];
            //[insertLength addObject:[NSString stringWithFormat:@"%lu", (unsigned long)textStr.length]];
            
            NSString *emjStr =[anyStr substringFromIndex:range.location];
            emjStr = [emjStr stringByReplacingOccurrencesOfString:@"<e>" withString:@""];
            
            if ([emjStr containsString:@"u"]) {
                
            }else {
                emjStr = [NSString stringWithFormat:@"u%@", emjStr];
            }
            
            endStr = [endStr stringByAppendingString:textStr];
            
            NSArray *rongCloundArr = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"rongCloudNameArrs"]];
            NSString *tempNameStr;
            for (int i = 0; i < rongCloundArr.count; i++) {
                if (i != 20 && i!= 41 && i != 62 && i!= 83 && i != 104 && i!= 125 && i!= 146) {
                    NSDictionary *dic = rongCloundArr[i];
                    NSString *nameStr = dic.allKeys.firstObject;
                    if ([nameStr isEqualToString:emjStr]) {
                        tempNameStr = dic[nameStr];
                        
                    }
                }
            }
            if (tempNameStr == nil) {
                
            }else {
                endStr = [endStr stringByAppendingString:tempNameStr];
            }
            
            [emjArr addObject:emjStr];
            
        }else {
            endStr = [endStr stringByAppendingString:anyStr];
            
        }
    }
    
    
    //    NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
    
    //    int j = 0;
    //
    //    for (int i = 0; i<insertLength.count; i++) {
    //        //添加表情
    //        NSString *str = emjArr[i];
    //
    //        str = [str stringByReplacingOccurrencesOfString:@"</e>" withString:@""];
    //      //  UIImage * image1 = [UIImage imageNamed:str];
    //
    //        NSArray *rongCloundArr = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"rongCloudNameArrs"]];
    //        for (int i = 0; i < rongCloundArr.count; i++) {
    //            if (i != 20 && i!= 41 && i != 62 && i!= 83 && i != 104 && i!= 125 && i!= 146) {
    //                NSDictionary *dic = rongCloundArr[i];
    //                NSString *nameStr = dic.allKeys.firstObject;
    //                if ([nameStr isEqualToString:str]) {
    //                    str = dic[nameStr];
    //                }
    //            }
    //
    //        }
    //        if (i == 0) {
    //            j += [insertLength[i] intValue];
    //        }else {
    //            j += [insertLength[i] intValue] + 2;
    //        }
    //
    //        [endStr insertString:str atIndex:j];
    //
    //
    //        NSLog(@" 图片名字%@",str);
    //
    ////        attachment1.bounds = CGRectMake(0, 0, 20, 20);
    ////        attachment1.image = image1;
    ////        NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
    //
    //
    //        if (j == 0) {
    //         //   [mutStr appendAttributedString:attachStr1];
    //        }else {
    //         //   [mutStr insertAttributedString:attachStr1 atIndex:j];
    //        }
    //    }
    // NSMutableAttributedString * mutStr = [[NSMutableAttributedString alloc]initWithString:endStr];
    return endStr;
}
//颜色转成图片
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIBarButtonItem *)addRightItemWithImage:(NSString *)imageName action:(SEL)action typeClass:(id)type{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // 这里需要注意：由于是想让图片右移，所以left需要设置为正，right需要设置为负。正在是相反的。
    // 让按钮图片右移15
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 13, 0, -13)];
    
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:type action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return  rightItem;
    //
}

// 判断输入的是只有空格
+(BOOL)isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


/** 时间处理*/
+ (NSString *)timeFormatted:(long long)totalSeconds
{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *timeSt1 = [dateFormatter stringFromDate:localeDate];
    timeSt1 = [timeSt1 stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
    
    NSDateFormatter* df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* str1 = [df2 stringFromDate:date];
    
    
    return str1;
}

/** 时间处理*/
+ (NSString *)timeFormattedTwo:(long long)totalSeconds
{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *timeSt1 = [dateFormatter stringFromDate:localeDate];
    timeSt1 = [timeSt1 stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
    
    NSDateFormatter* df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"yyyy-MM-dd"];
    NSString* str1 = [df2 stringFromDate:date];
    
    
    return str1;
}

// 返回宽度
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)//限制最大高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}

+ (NSString *)getNULLString:(NSObject *)obj
{
    if (obj == nil||obj==NULL) {
        return @"";
    }
    if([obj isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString*)obj;
    }
    else if([obj isKindOfClass:[NSNumber class]])
    {
        NSNumber* number = (NSNumber*)obj;
        return  [number stringValue];
    }
    return nil;
}

//颜色转图片
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return theImage;
}

+ (void)pushLoginViewControllerWithController:(UIViewController *)controller
{
    WLRegisteringViewController *loginVC = [[WLRegisteringViewController alloc] init];
    [controller.navigationController pushViewController:loginVC animated:YES];
}

+(CGSize)heightForText:(NSString *)value size:(CGSize )width font:(UIFont *)font
{
    CGSize sizeToFit;
    if(([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        sizeToFit = [value boundingRectWithSize:width options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    
    return sizeToFit;
    
}

+(UIImage *)getThumbnailImage:(NSString *)videoURL

{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;//按正确方向对视频进行截图,关键点是将AVAssetImageGrnerator对象的appliesPreferredTrackTransform属性设置为YES。
    
    CMTime time = CMTimeMakeWithSeconds(3, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;  
}

+ (NSMutableAttributedString *)getAttributeStringByHtmlString:(NSString *)htmlString
{
    NSMutableAttributedString *attrString =[[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_WORD_GRAY_1} range:NSMakeRange(0, attrString.length)];
    return attrString;
}

+ (NSMutableAttributedString *)getAttributeStringByHtmlString:(NSString *)htmlString fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    NSMutableAttributedString *attrString =[[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:textColor} range:NSMakeRange(0, attrString.length)];
    return attrString;
}


@end
