//
//  WLSharetowViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSharetowViewController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface WLSharetowViewController ()

@end

@implementation WLSharetowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    [self.wechatTimelineBtn addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    [self.WechatSession addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    [self.qqBtn addGestureRecognizer:tap3];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    [self.qZone addGestureRecognizer:tap4];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    [self.sinaBtn addGestureRecognizer:tap5];
}

- (void)shareAction:(UITapGestureRecognizer *)tap
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_shareTitle descr:_descStr thumImage:_imageUrl ? _imageUrl : [UIImage imageNamed:@"logo"]];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.esd-resource.com/";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    UMSocialPlatformType platfromType;
    
    switch (tap.view.tag) {
            
        case 1000:
            platfromType = UMSocialPlatformType_WechatTimeLine;
            break;
            
        case 1001:
            platfromType = UMSocialPlatformType_WechatSession;
            break;
            
        case 1002:
            platfromType = UMSocialPlatformType_QQ;
            break;
            
        case 1003:
            platfromType = UMSocialPlatformType_Qzone;
            break;
       
        case 1004:
            platfromType = UMSocialPlatformType_Sina;
            break;

        default:
            break;
    }
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platfromType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {

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

//取消
- (IBAction)CancellationClik:(id)sender {
    
    
[self dismissViewControllerAnimated:YES completion:nil];
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

//////点击屏幕退出
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}






@end
