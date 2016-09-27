//
//  WLHomeDataHandle.h
//  MyBoRuiSi
//
//  Created by Catski on 16/9/20.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLHomeDataHandle : NSObject

+ (void)requestHomeAdDataSuccess:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;


+ (void)requestHomeClassDetailWithCourseId:(NSString *)courseId
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure;

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
                            failure:(void (^)(NSError *error))failure;

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
                                failure:(void (^)(NSError *error))failure;

/**
 *  机构讲师列表
 *
 *  @param jid     机构ID
 *  @param success
 *  @param failure
 */
+ (void)requestInstitutionLecturersWithJid:(NSString *)jid
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure;

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
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

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
                             failure:(void (^)(NSError *error))failure;

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
                                failure:(void (^)(NSError *error))failure;

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
                            failure:(void (^)(NSError *error))failure;

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
                               failure:(void (^)(NSError *error))failure;



@end
