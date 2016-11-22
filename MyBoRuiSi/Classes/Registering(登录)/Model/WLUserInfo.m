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
- (instancetype)init
{
    self = [super init];
    if (self) {
         NSString *home = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
        _userInfoArchivPath = [home stringByAppendingPathComponent:@"userInfoArchiv"];
    }
    return self;
}

- (BOOL)isLogin
{
    return self.userId ? YES : NO;
}

- (void)archivWithDict:(NSDictionary *)dict{
    _address = dict[@"address"];
    _bagPwd = dict[@"bagPwd"];
    _birth = dict[@"birth"];
    _company = dict[@"company"];
    _job = dict[@"job"];
    _photo = dict[@"photo"];
    _sex = dict[@"sex"];
    _userId = dict[@"id"];
    _money = dict[@"money"];
    _nickname = dict[@"nickname"];
    _vipEndtm = dict[@"vipEndtm"];
    _vip = dict[@"vip"];
    _telphone = dict[@"telphone"];
    _favNum = dict[@"favNum"];
    _score = dict[@"score"];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:@"kUserInfo"];
    [archiver finishEncoding];
    
    [data writeToFile:self.userInfoArchivPath atomically:YES];
}

- (void)loadUserInfo{
    NSData *data = [[NSData alloc] initWithContentsOfFile:self.userInfoArchivPath];
    NSKeyedUnarchiver *unarchiv = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    WLUserInfo *userInfo = [unarchiv decodeObjectForKey:@"kUserInfo"];
    [unarchiv finishDecoding];
    
    _address = userInfo.address;
    _bagPwd = userInfo.bagPwd;
    _birth = userInfo.birth;
    _company = userInfo.company;
    _job = userInfo.job;
    _photo = userInfo.photo;
    _sex = userInfo.sex;
    _userId = userInfo.userId;
    _money = userInfo.money;
    _nickname = userInfo.nickname;
    _vipEndtm = userInfo.vipEndtm;
    _vip = userInfo.vip;
    _telphone = userInfo.telphone;
    _favNum = userInfo.favNum;
    _score = userInfo.score;
}

- (void)reArchivUserInfo{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:@"kUserInfo"];
    [archiver finishEncoding];
    
    [data writeToFile:self.userInfoArchivPath atomically:YES];
}

- (void)cleanUserInfo{
    NSFileManager *manager = [NSFileManager defaultManager];
    // 删除
    BOOL isDelete = [manager removeItemAtPath:self.userInfoArchivPath error:nil];
    if(isDelete){
        _userId = nil;
    }else{
        [self archivWithDict:nil];
    }
}


#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _address = [aDecoder decodeObjectForKey:@"address"];
        _bagPwd = [aDecoder decodeObjectForKey:@"bagPwd"];
        _birth = [aDecoder decodeObjectForKey:@"birth"];
        _company = [aDecoder decodeObjectForKey:@"company"];
        _job = [aDecoder decodeObjectForKey:@"job"];
        _photo = [aDecoder decodeObjectForKey:@"photo"];
        _sex = [aDecoder decodeObjectForKey:@"sex"];
        _userId = [aDecoder decodeObjectForKey:@"id"];
        _money = [aDecoder decodeObjectForKey:@"money"];
        _nickname = [aDecoder decodeObjectForKey:@"nickname"];
        _vipEndtm = [aDecoder decodeObjectForKey:@"vipEndtm"];
        _vip = [aDecoder decodeBoolForKey:@"vip"];
        _telphone = [aDecoder decodeObjectForKey:@"telphone"];
        _favNum = [aDecoder decodeObjectForKey:@"favNum"];
        _score = [aDecoder decodeObjectForKey:@"score"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_bagPwd forKey:@"bagPwd"];
    [aCoder encodeObject:_birth forKey:@"birth"];
    [aCoder encodeObject:_company forKey:@"company"];
    [aCoder encodeObject:_favNum forKey:@"favNum"];
    [aCoder encodeObject:_userId forKey:@"id"];
    [aCoder encodeObject:_job forKey:@"job"];
    [aCoder encodeObject:_photo forKey:@"photo"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_money forKey:@"money"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeObject:_vipEndtm forKey:@"vipEndtm"];
    [aCoder encodeBool:_vip forKey:@"vip"];
    [aCoder encodeObject:_telphone forKey:@"telphone"];
    [aCoder encodeObject:_score forKey:@"score"];
}

#pragma mark - NSCoping
//- (id)copyWithZone:(NSZone *)zone {
//    WLUserInfo *copy = [[[self class] allocWithZone:zone] init];
//    copy.money = [self.money copyWithZone:zone];
//   
//    return copy;
//}
@end
