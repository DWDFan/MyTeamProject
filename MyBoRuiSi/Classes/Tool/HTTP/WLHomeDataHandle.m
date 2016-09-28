//
//  WLHomeDataHandle.m
//  MyBoRuiSi
//
//  Created by Catski on 16/9/20.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLHomeDataHandle.h"
#import "MOHTTP.h"

@implementation WLHomeDataHandle

/**
 *  首页广告
 *
 *  @param success
 *  @param failure
 */

+ (void)requestHomeAdDataSuccess:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Ad&do=homeAd" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  课程详情
 *
 *  @param courseId     课程ID
 *  @param success
 *  @param failure
 */
+ (void)requestHomeClassDetailWithCourseId:(NSString *)courseId
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Kecheng&do=classDetail" parameters:@{@"id":courseId}
     
    success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  教师详情
 *
 *  @param uid     用户ID
 *  @param jid     教师ID
 *  @param success
 *  @param failure
 */
+ (void)requestTeacherDetailWithUid:(NSString *)uid
                                jid:(NSString *)jid
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"uid":uid, @"tid":jid};
    
    [MOHTTP GET:@"API/index.php?action=Teacher&do=getDetail" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  机构详情
 *
 *  @param uid     用户ID
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestInstitutionDetailWithUid:(NSString *)uid
                                    jid:(NSString *)jid
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"uid":uid, @"jid":jid};
    
    [MOHTTP GET:@"API/index.php?action=Jigou&do=getDetail" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  机构讲师列表
 *
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestInstitutionLecturersWithJid:(NSString *)jid
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure
{
    
    [MOHTTP GET:@"API/index.php?action=Jigou&do=teachers" parameters:@{@"jid":jid} success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  搜索课程
 *
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestSearchCourseWithNum:(NSNumber *)num
                              page:(NSNumber *)page
                               key:(NSString *)key
                              type:(NSNumber *)type
                              ppid:(NSString *)ppid
                        priceOrder:(NSString *)priceOrder
                          zbstatus:(NSNumber *)zbstatus
                           saleNum:(NSString *)saleNum
                             level:(NSNumber *)level
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"num":num,
                            @"page":page,
                            @"key":key,
                            @"type":type,
                            @"ppid":ppid,
                            @"priceOrder":priceOrder,
                            @"zbstatus":zbstatus,
                            @"saleNum":saleNum,
                            @"level":level};

    [MOHTTP GET:@"API/index.php?action=So&do=soClass" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  搜索讲师
 *
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestSearchLecturerWithNum:(NSNumber *)num
                                page:(NSNumber *)page
                                 key:(NSString *)key
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"num":num,
                            @"page":page,
                            @"key":key};
    
    [MOHTTP GET:@"API/index.php?action=So&do=soTeacher" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  搜索机构
 *
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestSearchInstitutionWithNum:(NSNumber *)num
                                   page:(NSNumber *)page
                                    key:(NSString *)key
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"num":num,
                            @"page":page,
                            @"key":key};
    
    [MOHTTP GET:@"API/index.php?action=So&do=soJigou" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  搜索帖子
 *
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestSearchArticleWithNum:(NSNumber *)num
                               page:(NSNumber *)page
                                key:(NSString *)key
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *param = @{@"num":num,
                            @"page":page,
                            @"key":key};
    
    [MOHTTP GET:@"API/index.php?action=So&do=soPost" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  标准搜索
 *
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestSearchStandardWithNum:(NSNumber *)num
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"num":num};
    
    [MOHTTP GET:@"API/index.php?action=So" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  证书查询
 *
 *  @param uid     用户ID
 *  @param name    名字
 *  @param card_id 身份证
 *  @param zs_num  证书号
 *  @param success
 *  @param failure
 */
+ (void)requestQueryCertificateWithUid:(NSString *)uid
                                  name:(NSString *)name
                               card_id:(NSString *)card_id
                                zs_num:(NSString *)zs_num
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"uid":uid,
                            @"name":name,
                            @"card_id":card_id ? card_id : [NSNull null],
                            @"zs_num":zs_num ? zs_num : [NSNull null]};

    [MOHTTP GET:@"API/index.php?action=Ccie&do=soCcie" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
