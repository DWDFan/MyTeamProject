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
@end
