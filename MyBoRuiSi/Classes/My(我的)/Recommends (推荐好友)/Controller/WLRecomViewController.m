//
//  WLRecomViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLRecomViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WLQRCodeViewController.h"

@interface WLRecomViewController ()

@end

@implementation WLRecomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"推荐好友" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];

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

- (IBAction)qrScan:(id)sender {
    WLQRCodeViewController *qrCodeVC = [[WLQRCodeViewController alloc] init];
    [self.navigationController pushViewController:qrCodeVC animated:YES];
}

- (IBAction)shareSms:(id)sender {
    
    [self shareToPlatformType:UMSocialPlatformType_Sms];
}

- (IBAction)shareWechatTimeline:(id)sender {
    
    [self shareToPlatformType:UMSocialPlatformType_WechatTimeLine];
}

- (IBAction)shareWechatSession:(id)sender {
    
    [self shareToPlatformType:UMSocialPlatformType_WechatSession];
}

- (IBAction)shareQQ:(id)sender {
    
    [self shareToPlatformType:UMSocialPlatformType_QQ];
}

- (IBAction)shareQzone:(id)sender {
    
    [self shareToPlatformType:UMSocialPlatformType_Qzone];
}

- (IBAction)shareWeibo:(id)sender {
    
    [self shareToPlatformType:UMSocialPlatformType_Sina];
}

- (void)shareToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"博瑞思" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.esd-resource.com/";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功!"];
    }
    else{
        result = [NSString stringWithFormat:@"分享失败!"];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
