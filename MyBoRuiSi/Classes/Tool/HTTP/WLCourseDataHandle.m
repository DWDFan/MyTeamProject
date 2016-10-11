//
//  WLCourseDataHandle.m
//  MyBoRuiSi
//
//  Created by Catski on 16/9/24.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCourseDataHandle.h"
#import "MOHTTP.h"

@implementation WLCourseDataHandle

/**
 *  课程大纲
 *
 *  @param id     ID
 *  @param success
 *  @param failure
 */
+ (void)requestCourceOutLineWithCourseId:(NSString *)cid
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"id":cid};
    
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=getDaGang" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"kid":cid,
                            @"uid":uid};
    
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=getKejian" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  所有评论
 *
 *  @param cid     ID
 *  @param success
 *  @param failure
 */
+ (void)requestCourceAllCommentWithCourseId:(NSString *)cid
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=getComments" parameters:@{@"id":cid} success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  热门课程类型
 *
 *  @param success
 *  @param failure
 */
+ (void)requestHotCourseTypeSuccess:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=hotType" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 *  课程搜索条件
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseFilterSuccess:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=getSoFilter" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 *  推荐课程类型
 *
 *  @param success
 *  @param failure
 */
+ (void)requestRecommendCourseTypeSuccess:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=commandType" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"id":cid,
                            @"uid":uid,
                            @"star":star,
                            @"msg":msg};
    
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=commentClass" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  获取两条直播
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseLiveSuccess:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Zhibo&do=onRand" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 *  获取直播详情
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseLiveDetailWithId:(NSString *)cid
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Zhibo&do=classDetail" parameters:@{@"id":cid} success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  收藏课程
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCollectCourseWithCourseId:(NSString *)cid
                                     uid:(NSString *)uid
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"id" : cid,
                            @"uid" : uid};
    
    [MOHTTP GET:@"API/index.php?action=Zhibo&do=classDetail" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  关注机构
 *
 *  @param success
 *  @param failure
 */
+ (void)requestCourseLiveDetailWithInstitutionId:(NSString *)jid
                                             uid:(NSString *)uid
                                         success:(void (^)(id responseObject))success
                                         failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"id" : jid,
                            @"uid" : uid};
   
    [MOHTTP GET:@"API/index.php?action=Jigou&do=focusJg" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}




@end
