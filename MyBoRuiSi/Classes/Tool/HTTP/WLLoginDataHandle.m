//
//  WLLoginDataHandle.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLoginDataHandle.h"

@implementation WLLoginDataHandle

/**
 *  获取验证码
 *
 *  @param telphone 手机号
 *  @param success
 *  @param failure
 
 正常
 {
    code = 1;
    msg =     {
        code = 80319;
        msg = "\U53d1\U9001\U6210\U529f";
    };
    statusCode = "(null)";
 }
 
 异常
 {
    code = 1;
    msg = "<null>";
    statusCode = "(null)";
 }

 
 */
+ (void)requestTelCodeWithTelphone:(NSString *)telphone
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"telphone":telphone};
    
    [MOHTTP GET:@"API/index.php?action=Login&do=getTelCode" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  注册
 *
 *  @param telphone 手机号
 *  @param code     验证码
 *  @param yqcode   邀请码
 *  @param success
 *  @param failure
 
 {
    code = 1;
    id = 16;
    msg = "\U6ce8\U518c\U6210\U529f";
    statusCode = "(null)";
    telphone = 13288661234;
 }
 */
+ (void)requestRegisterWithTelphone:(NSString *)telphone
                               code:(NSString *)code
                             yqcode:(NSString *)yqcode
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"telphone":telphone,
                            @"code":code,
                            @"yqcode":yqcode};
    
    [MOHTTP GET:@"API/index.php?action=Login&do=Reg" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  登录
 *
 *  @param telphone 手机号
 *  @param code     验证码
 *  @param success
 *  @param failure
 */
+ (void)requestLoginWithTelphone:(NSString *)telphone
                            code:(NSString *)code
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"telphone":telphone,
                            @"code":code};
    
    [MOHTTP GET:@"API/index.php?action=Login&do=Index" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  完善个人信息
 *
 *  @param uid      用户Id
 *  @param photo    头像
 *  @param sex      性别
 *  @param nickname 昵称
 *  @param year     出生年份
 *  @param month    出生月份
 *  @param day      出生日期
 *  @param job      职业
 *  @param address  地址
 *  @param success
 *  @param failure
 */
+ (void)requestPerfectPersonalInfoWithUid:(NSString *)uid
                                    photo:(NSString *)photo
                                      sex:(NSString *)sex
                                 nickname:(NSString *)nickname
                                     year:(NSString *)year
                                    month:(NSString *)month
                                      day:(NSString *)day
                                      job:(NSString *)job
                                  address:(NSString *)address
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure
{
//    if (!nickname || !uid) failure(nil);
    
    NSDictionary *param = @{@"uid":uid,
                            @"photo":photo ? photo : [NSNull null],
                            @"sex":sex? sex : [NSNull null],
                            @"nickname":nickname,
                            @"year":year? year : [NSNull null],
                            @"month":month? month : [NSNull null],
                            @"day":day? day : [NSNull null],
                            @"job":job? job : [NSNull null],
                            @"address":address? address : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=User&do=finishInfo" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 *  上传头像
 *
 *  @param uid      用户Id
 *  @param filedata 头像数据
 *  @param success
 *  @param failure
 
 {
    code = 1;
    link = "http://brs.yerhu.com/API/upload/1474970222.jpg";
    msg = ok;
    statusCode = "(null)";
 }
 */
+ (void)requestUploadPhotoWithUid:(NSString *)uid
                         filedata:(NSData *)filedata
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"uid":uid, @"Filedata":filedata};
    
    [MOHTTP Post:@"API/index.php?action=Upload&do=appUpload" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    

}

@end
