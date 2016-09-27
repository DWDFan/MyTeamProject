//
//  UIImage+Image.m
//  传智微博
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
//没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
   UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

//没有拉伸
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)cleImage:(UIColor *)color
{
    CGRect rect =  CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ref, color.CGColor);
    CGContextFillRect(ref, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
