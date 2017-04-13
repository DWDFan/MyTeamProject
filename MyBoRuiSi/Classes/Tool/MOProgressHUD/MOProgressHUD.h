//
//  MOProgressHUD.h
//  E农会
//
//  Created by 莫瑞伟 on 16/5/30.
//  Copyright © 2016年 莫瑞伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOProgressHUD : NSObject

+ (void)show;
+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)time;
+ (void)showErrorWithStatus:(NSString *)meagess;
+ (void)showSuccessWithStatus:(NSString *)meagess;
+ (void)showImage:(UIImage *)image withStatus:(NSString *)status;
+ (void)showWithStatus:(NSString *)status;
+ (void)showInfo:(NSString *)info;


@end
