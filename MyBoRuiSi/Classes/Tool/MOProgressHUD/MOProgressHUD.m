//
//  MOProgressHUD.m
//  E农会
//
//  Created by 莫瑞伟 on 16/5/30.
//  Copyright © 2016年 莫瑞伟. All rights reserved.
//

#import "MOProgressHUD.h"
#import "SVProgressHUD.h"
@implementation MOProgressHUD
+ (void)show
{
    [self initProgress];
    [SVProgressHUD show];
}
+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)time
{
    [SVProgressHUD dismissWithDelay:time];
}

+ (void)showErrorWithStatus:(NSString *)meagess
{
    [self initProgress];
    
    [SVProgressHUD showErrorWithStatus:meagess];
}
+ (void)showSuccessWithStatus:(NSString *)meagess
{
    [self initProgress];
    [SVProgressHUD showSuccessWithStatus:meagess];
}
+ (void)showImage:(UIImage *)image withStatus:(NSString *)status
{
    [self initProgress];
    [SVProgressHUD showImage:image status:status];
}
+ (void)showWithStatus:(NSString *)status
{
    [self initProgress];
    [SVProgressHUD showWithStatus:status];
}

+ (void)showWithStatus:(NSString *)status WithTarget:(UIView *)target
{
    
}

+ (void)showInfo:(NSString *)info
{
    [SVProgressHUD showInfoWithStatus:info];
}

+ (void)initProgress
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1.45];
    [SVProgressHUD setFadeOutAnimationDuration:0.35];
}

@end
