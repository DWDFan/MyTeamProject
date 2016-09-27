//
//  WLUserInfo.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLUserInfo.h"

@implementation WLUserInfo

+ (WLUserInfo *)share
{
    static WLUserInfo *userInfo = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[WLUserInfo alloc] init];
    });
    
    return userInfo;
}

- (BOOL)isLogin
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] integerValue] == 1 ? YES : NO;
}

@end
