//
//  WLMyDataHandle.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLMyDataHandle : NSObject

/**
 *  获取vip价格表
 *
 *  @param uid     用户ID
 *  @param success
 *  @param failure
 */
+ (void)requestGetVipFeeWithUid:(NSString *)uid
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  vip续费
 *
 *  @param uid     用户ID
 *  @param year    几年
 *  @param success
 *  @param failure
 */
+ (void)requestBuyVipWithUid:(NSString *)uid
                        year:(NSNumber *)year
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  我的收入
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyInComeWithUid:(NSString *)uid
                                page:(NSNumber *)page
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

/**
 *  我的支出
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyCostWithUid:(NSString *)uid
                             page:(NSNumber *)page
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  用户临时加钱入口   此接口给开发者调用来加余额，用来测试的
 *
 *  @param uid     用户ID
 *  @param success
 *  @param failure
 */
+ (void)requestAddMoneyWithUid:(NSString *)uid
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;



/**
 *  获取我的论坛回复
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetReplyWithUid:(NSString *)uid
                        page:(NSNumber *)page
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;
/**
 *  获取我的系统消息
 *
 *  @param uid     用户ID
 *  @param type     消息类型 system 系统消息
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMsgWithUid:(NSString *)uid
                        page:(NSNumber *)page
                        type:(NSString *)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  获取我的系统消息详情
 *
 *  @param uid     用户ID
 *  @param id     消息id
 *  @param success
 *  @param failure
 */
+ (void)requestGetMsgInfoWithUid:(NSString *)uid
                              id:(NSString *)infoId
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;
/**
 *  我的收藏
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param type     收藏类型 1 帖子 2 课程
 *  @param success
 *  @param failure
 */
+ (void)requestGetFavListWithUid:(NSString *)uid
                             page:(NSNumber *)page
                             type:(NSNumber *)type
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  获取我的试卷
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyTestWithUid:(NSString *)uid
                            page:(NSNumber *)page
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  获取我的点播课程
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyCourseWithUid:(NSString *)uid
                           page:(NSNumber *)page
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  获取我的直播课程
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyZhiBoWithUid:(NSString *)uid
                             page:(NSNumber *)page
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  获取我的企业内部课程
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyQiyeKcWithUid:(NSString *)uid
                            page:(NSNumber *)page
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  获取我的帖子
 *
 *  @param uid     用户ID
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyPostWithUid:(NSString *)uid
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
/**
 *  删除我的帖子
 *
 *  @param uid     用户ID
 *  @param tid     帖子id
 *  @param success
 *  @param failure
 */
+ (void)requestDeleteMyPostWithUid:(NSString *)uid
                               tid:(NSString *)tid
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

/**
 *  获取我的关注讲师列表
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyFollowJsWithUid:(NSString *)uid
                             page:(NSNumber *)page
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  获取我的关注机构列表
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetMyFollowJgWithUid:(NSString *)uid
                             page:(NSNumber *)page
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
/**
 *  修改个人资料
 *
 *  @param uid     用户ID
 *  @param key     修改字段
 *  @param val     字段内容
 *  @param success
 *  @param failure
 'nickname' 名字
 'sex' 性别 (男/女)
 'photo' 头像
 'birth' 生日
 'job' 工作
 'company' 公司
 'address' 地址
 */
+ (void)requestUpdateInfoWithUid:(NSString *)uid
                             key:(NSString *)key
                             val:(NSString *)val
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  设置支付密码
 *
 *  @param uid     用户ID
 *  @param pwd     密码（算法小写32位MD5）
 *  @param success
 *  @param failure
 */
+ (void)requestSetPwdWithUid:(NSString *)uid
                         pwd:(NSString *)pwd
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;
/**
 *  修改我的钱包密码
 *
 *  @param uid     用户ID
 *  @param oldpwd  旧密码（算法小写32位MD5）
 *  @param pwd     密码（算法小写32位MD5）
 *  @param success
 *  @param failure
 */
+ (void)requestUpdatePwdWithUid:(NSString *)uid
                         oldpwd:(NSString *)oldpwd
                            pwd:(NSString *)pwd
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  验证我的钱包密码
 *
 *  @param uid     用户ID
 *  @param pwd     密码（算法小写32位MD5）
 *  @param success
 *  @param failure
 */
+ (void)requestCheckPwdWithUid:(NSString *)uid
                           pwd:(NSString *)pwd
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/**
 *  忘记密码
 *
 *  @param uid     用户ID
 *  @param telphone     手机号
 *  @param code     验证码
 *  @param pwd      新密码
 */
+ (void)requestForgetPwdWithUid:(NSString *)uid
                            pwd:(NSString *)pwd
                       telphone:(NSString *)telphone
                           code:(NSString *)code
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;
@end
