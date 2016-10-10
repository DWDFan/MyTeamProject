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
        NSString *home = NSHomeDirectory();
        _userInfoArchivPath = [home stringByAppendingPathComponent:@"userInfoArchiv"];
    }
    return self;
}

- (BOOL)isLogin
{
    return self.userId ? YES : NO;
}

- (void)archivWithDict:(NSDictionary *)dict{
    _userId = dict[@"id"];
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
    
    _userId = userInfo.userId;
    _nickname = userInfo.nickname;
    _vipEndtm = userInfo.vipEndtm;
    _vip = userInfo.vip;
    _telphone = userInfo.telphone;
    _favNum = userInfo.favNum;
    _score = userInfo.score;
}

- (void)cleanUserInfo{
    NSFileManager *manager = [NSFileManager defaultManager];
    // 删除
    BOOL isDelete = [manager removeItemAtPath:self.userInfoArchivPath error:nil];
    _userId = nil;
}


#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _userId = [aDecoder decodeObjectForKey:@"id"];
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
    [aCoder encodeObject:_userId forKey:@"id"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeObject:_vipEndtm forKey:@"vipEndtm"];
    [aCoder encodeBool:_vip forKey:@"vip"];
    [aCoder encodeObject:_telphone forKey:@"telphone"];
    [aCoder encodeObject:_favNum forKey:@"favNum"];
    [aCoder encodeObject:_score forKey:@"score"];
}
@end
