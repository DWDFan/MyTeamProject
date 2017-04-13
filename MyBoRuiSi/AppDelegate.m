//
//  AppDelegate.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "AppDelegate.h"
#import "WLTabBarController.h"
#import "WLRoot.h"

#import "Pingpp.h"
#import "AdvertiseHelper.h"
#import "WLHomeDataHandle.h"
#import <UMSocialCore/UMSocialCore.h>
#import <IQKeyboardManager.h>
#import "AFNetworkReachabilityManager.h"
#import "CZNewfeatureController.h"
#import "AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 键盘管理
    [self configureBoardManager];
    
    //创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [WLRoot chooseRootViewController:self.window];
    [self.window makeKeyAndVisible];

    // 加载广告
    [self setupAdveriseView];

    [Pingpp setDebugMode:YES];
//    [Pingpp setAppId:@"wxfb47bc395d2a44e7"];
    //加载用户信息
    [[WLUserInfo share] loadUserInfo];
    
    //友盟分享及第三方登录初始化
    [self initLoadUMSocial];
    
    [self starNetworkMonitor];
    
    return YES;
}

#pragma mark 启动广告
-(void)setupAdveriseView
{
    // TODO 请求广告接口 获取广告图片
    [WLHomeDataHandle requestLaunchAdvertiseWithType:@1 success:^(id responseObject) {
        
        NSString *image = responseObject[@"data"];
        NSString *imageUrl = [image stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [AdvertiseHelper showAdvertiserView:imageUrl];

    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 初始化友盟分享
-(void)initLoadUMSocial
{
    //打开调试log的开关
    //打开日志
//    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"580f143e75ca354d62002dd5"];
    
    // 获取友盟social版本号
    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //各平台的详细配置
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxfb47bc395d2a44e7" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106031750"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //设置新浪的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"251755376"  appSecret:@"840417395e137947d0e968d95bfd615b" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}


// iOS 8 及以下请用这个
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [Pingpp handleOpenURL:url withCompletion:nil] ||
           [[UMSocialManager defaultManager] handleOpenURL:url];}

// iOS 9 以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {

    return [Pingpp handleOpenURL:url withCompletion:nil] ||
           [[UMSocialManager defaultManager] handleOpenURL:url];
}

#pragma mark - 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=40;
    
    //    manager.enableAutoToolbar = NO;
}

- (void)starNetworkMonitor
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                if (![[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[CZNewfeatureController class]]) {
                    [MOProgressHUD showInfo:@"未知的网络"];
                }
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                if (![[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[CZNewfeatureController class]]) {
                    [MOProgressHUD showInfo:@"无法连接网络"];
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (![[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[CZNewfeatureController class]]) {
                    [MOProgressHUD showInfo:@"正在使用WIFI网络"];
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (![[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[CZNewfeatureController class]]) {
                    [MOProgressHUD showInfo:@"正在使用手机移动网络"];
                }
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
