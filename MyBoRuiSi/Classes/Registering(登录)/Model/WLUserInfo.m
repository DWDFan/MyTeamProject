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
    return self.userId ? YES : NO;
}

- (void)loadUserInfo{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    _userId = dict[@"id"];
    _nickname = dict[@"nickname"];
    _vipEndtm = dict[@"vipEndtm"];
    _vip = dict[@"vip"];
    _telphone = dict[@"telphone"];
    _favNum = dict[@"favNum"];
    _score = dict[@"scre"];
}

- (void)cleanUserInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
    _userId = nil;
}
@end
