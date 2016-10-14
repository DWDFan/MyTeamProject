//
//  WLCourseDataHandle.h
//  MyBoRuiSi
//
//  Created by Catski on 16/9/24.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCourseDataHandle : NSObject

/**
 *  课程大纲
 *
 *  @param cid     ID
 *  @param success
 *  @param failure
 */
+ (void)requestCourceOutLineWithCourseId:(NSString *)cid
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

/**
 获取课件列表

 @param cid     kid 课程id
 @param uid     uid 用户id
 @param success
 @param failure
 */
+ (void)requestCoursewareWithCourseId:(NSString *)cid
                                  uid:(NSString *)uid
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;


/**
 课件预览
 
 @param uid     uid 用户id
 @param kid     kid 课件id
 @param success
 @param failure
 */
+ (void)requestCoursewarePreVWithUserId:(NSString *)uid
                                    kid:(NSString *)kid
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;
/**
 *  所有评论
 *
 *  @param cid     ID
 *  @param success
 *  @param failure
 */
+ (void)requestCourceAllCommentWithCourseId:(NSString *)cid
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;


/**
 *  热门课程类型
 *
 *  @param success
 *  @param failure
 */
+ (void)requestHotCourseTypeSuccess:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;


/**
 *  课程搜索条件
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseFilterSuccess:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;


/**
 *  推荐课程类型
 *
 *  @param success
 *  @param failure
 */
+ (void)requestRecommendCourseTypeSuccess:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure;

/**
 *  添加评论
 *
 *  @param success
 *  @param failure
 */
+ (void)requestAddCommentWithCourseId:(NSString *)cid
                                  uid:(NSString *)uid
                                 star:(NSNumber *)star
                                  msg:(NSString *)msg
                              success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

/**
 *  获取两条直播
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseLiveSuccess:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;


/**
 *  获取直播详情
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseLiveDetailWithId:(NSString *)cid
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure;

/**
 *  收藏课程
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCollectCourseWithCourseId:(NSString *)cid
                                     uid:(NSString *)uid
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

/**
 *  关注机构
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseLiveDetailWithInstitutionId:(NSString *)jid
                                             uid:(NSString *)uid
                                         success:(void (^)(id responseObject))success
                                         failure:(void (^)(NSError *error))failure;


@end
