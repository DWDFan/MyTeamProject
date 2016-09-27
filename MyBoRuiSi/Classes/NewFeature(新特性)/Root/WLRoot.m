//
//  WLRoot.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/13.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLRoot.h"
#import "WLTabBarController.h"
#import "CZNewfeatureController.h"
#define CZVersionKey @"version"


@implementation WLRoot


//选择控制器
+(void)chooseRootViewController:(UIWindow *)window
{
    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //获取上一次版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:CZVersionKey];
    // v1.0
    // 判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
        
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        WLTabBarController *vc = [[WLTabBarController alloc] init];
        
        window.rootViewController = vc;
        
        
        // 创建tabBarVc
        //        CZTabBarController *tabBarVc = [[CZTabBarController alloc] init];
        //
        //        // 设置窗口的根控制器
        //        self.window.rootViewController = tabBarVc;
        
        
    }else{ // 有最新的版本号
        
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        CZNewfeatureController *vc = [[CZNewfeatureController alloc] init];
        
        window.rootViewController = vc;
        
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:CZVersionKey];
    }
    
    
}



@end
