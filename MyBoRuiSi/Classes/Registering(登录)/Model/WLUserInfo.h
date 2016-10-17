//
//  WLUserInfo.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLUserInfo : NSObject<NSCoding>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *vipEndtm;
@property (nonatomic, strong) NSString *telphone;
@property (nonatomic, strong) NSNumber *favNum;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *birth;
@property (nonatomic, assign, getter=isVip) BOOL vip;

@property (nonatomic, strong) NSString *userInfoArchivPath;
+ (WLUserInfo *)share;

/** 归档 保存用户数据*/
- (void)archivWithDict:(NSDictionary *)dict;
/** 解档 加载用户数据 */
- (void)loadUserInfo;

/** 修改用户数据 重新归档 */
- (void)reArchivUserInfo;
/** 清除用户数据 */
- (void)cleanUserInfo;


@end
/*
{
 address = "";
 bagPwd = 1;
 birth = "";
 company = "";
 favNum = 2;
 hadJg = 1;
 id = 17;
 job = "";
 money = 599970;
 nickname = "\U6682\U65e0";
 photo = "";
 score = 30;
 sex = "";
 telphone = 13288664746;
 vip = 0;
 vipEndtm = "";
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
