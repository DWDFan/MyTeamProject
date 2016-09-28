//
//  WLUserInfo.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLUserInfo : NSObject

@property (nonatomic, strong, readonly) NSString *userId;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *vipEndtm;
@property (nonatomic, strong) NSNumber *telphone;
@property (nonatomic, strong) NSNumber *favNum;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, assign, getter=isVip) BOOL vip;
+ (WLUserInfo *)share;

/** 加载用户数据 */
- (void)loadUserInfo;

/** 清除用户数据 */
- (void)cleanUserInfo;
@end
/*
{
    bagPwd = 0;
    code = 1;
    favNum = 100;
    hadJg = 1;
    id = 17;
    money = "<null>";
    msg = "\U767b\U9646\U6210\U529f";
    nickname = "\U6682\U65e0";
    score = 0;
    statusCode = "(null)";
    telphone = 13288664746;
    vip = 0;
    vipEndtm = "<null>";
}

vipEndtm vip过期日期
favNum 收藏数
score 积分
nickname 昵称
money 钱包余额
vip 是否是vip
hadJg 是否参入了机构
telphone 手机号
*/