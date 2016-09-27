//
//  WLLoginDataHandle.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLLoginDataHandle : NSObject

/**
 *  获取验证码
 *
 *  @param telphone 手机号
 *  @param success
 *  @param failure
 */
+ (void)requestTelCodeWithTelphone:(NSString *)telphone
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

/**
 *  注册
 *
 *  @param telphone 手机号
 *  @param code     验证码
 *  @param yqcode   邀请码
 *  @param success
 *  @param failure
 */
+ (void)requestRegisterWithTelphone:(NSString *)telphone
                               code:(NSString *)code
                             yqcode:(NSString *)yqcode
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

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
                            failure:(void (^)(NSError *error))failure;

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
                                  failure:(void (^)(NSError *error))failure;

/**
 *  上传头像
 *
 *  @param uid      用户Id
 *  @param filedata 头像数据
 *  @param success
 *  @param failure
 */
+ (void)requestUploadPhotoWithUid:(NSString *)uid
                         filedata:(NSData *)filedata
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
@end
