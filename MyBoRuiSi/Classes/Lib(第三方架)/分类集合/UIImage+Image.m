//
//  UIBarButtonItem+Item.h
//
//
//  Created by apple on 12-3-5.
//  Copyright (c) 2012年 MO. All rights reserved.
//


#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
   UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


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
