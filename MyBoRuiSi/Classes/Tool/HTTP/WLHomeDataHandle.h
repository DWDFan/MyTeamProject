//
//  WLHomeDataHandle.h
//  MyBoRuiSi
//
//  Created by Catski on 16/9/20.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLHomeDataHandle : NSObject


/**
 获取广告

 @param success
 @param failure
 */
+ (void)requestHomeAdDataSuccess:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;


/**
 获取推荐讲师

 @param num     数量
 @param success
 @param failure 
 */
+ (void)requestHomeRecommendLectureWithNum:(NSNumber *)num
                                   Success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure;


/**
 获取推荐机构

 @param num     数量
 @param success
 @param failure
 */
+ (void)requestHomeRecommendInstitutionWithNum:(NSNumber *)num
                                   Success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure;


/**
 关注讲师

 @param uid     uid
 @param tid     tid
 @param type    1 关注，0取消关注
 @param success
 @param failure
 */
+ (void)requestHomeFollowLectureWithUid:(NSString *)uid
                                    tid:(NSString *)tid
                                   type:(NSNumber *)type
                                Success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

/**
 关注机构
 
 @param uid     uid
 @param tid     tid
 @param type    1 关注，0取消关注
 @param success
 @param failure
 */
+ (void)requestHomeFollowInstitutionWithUid:(NSString *)uid
                                    jid:(NSString *)jid
                                   type:(NSNumber *)type
                                Success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;


/**
 获取课程详情

 @param courseId 课程ID
 @param success
 @param failure
 */
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
 加入机构

 @param uid      uid 用户id
 @param jid      jid 机构id
 @param name     name 名字
 @param telphone telphone 手机号
 @param depart   depart 部门
 @param success
 @param failure
 */
+ (void)requestInstitutionJoinWithUid:(NSString *)uid
                                  jid:(NSString *)jid
                                 name:(NSString *)name
                             telphone:(NSString *)telphone
                               depart:(NSString *)depart
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
                           saleNum:(NSString *)saleNum
                             level:(NSNumber *)level
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

/**
 *  获取试卷类型
 *
 *  @param success
 *  @param failure
 */
+ (void)requestPaperTypeSuccess:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  获取试卷列表
 *
 *  @param type 类型
 *  @param success
 *  @param failure
 */
+ (void)requestPaperListWithType:(NSString *)type
                            page:(NSNumber *)page
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  获取试卷内容
 *
 *  @param type 类型
 *  @param success
 *  @param failure
 */
+ (void)requestPaperContentWithId:(NSString *)paperId
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  根据题型获取题目列表
 *
 *  @param type 类型
 *  @param success
 *  @param failure
 */
+ (void)requestPaperDetailWithId:(NSString *)paperId
                            type:(NSNumber *)type
                             qid:(NSString *)qid
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  提交答案
 *
 *  @param type 类型
 *  @param success
 *  @param failure
 */
+ (void)requestSubmitAnswerWithId:(NSString *)paperId
                              aid:(NSString *)aid
                              tid:(NSString *)tid
                              uid:(NSString *)uid
                           answer:(NSString *)answer
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;


+ (void)requestLaunchAdvertiseWithType:(NSNumber *)type
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;


+ (void)requestInstitutionCourseListWithUid:(NSString *)uid
                                        jid:(NSString *)jid
                                       type:(NSNumber *)type
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;

+ (void)requestPaperStarTestWithUid:(NSString *)uid
                                tid:(NSString *)tid
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

+ (void)requestPaperEndTestWithUid:(NSString *)uid
                               tid:(NSString *)tid
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

+ (void)requestPaperTestSubmitAnswerWithAid:(NSString *)aid
                                        tid:(NSString *)tid
                                         id:(NSString *)Id
                                     answer:(NSString *)answer
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;


+ (void)requestExaminationWithUid:(NSString *)uid
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

//地址： API/index.php?action=Kaoshi&do=startMyKaoshi
//参数： uid
//kid tb_user_kaoshi中id
//mid 考试题目id
+ (void)requestStartExaminationWithUid:(NSString *)uid
                                   kid:(NSString *)kid
                                   mid:(NSString *)mid
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;

//
//地址： API/index.php?action=Kaoshi&do=getKaoshiType
//参数： uid 用户id
//kid 课程id
//返回： {code:code , msg:msg , data:数据列表}
//返回字段描述：
//code: 1 接口调用成功，其他表示异常
//msg: 消息提示
+ (void)requestExaminationTypeWithUid:(NSString *)uid
                                  kid:(NSString *)kid
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure;


//地址： API/index.php?action=Kaoshi&do=getKaoshi
//参数： uid 用户id
//kid 考试id
//type 考试类型
//返回： {code:code , msg:msg , data:数据列表}
//返回字段描述：
//code: 1 接口调用成功，其他表示异常
//msg: 消息提示
+ (void)requestExaminationContentWithUid:(NSString *)uid
                                     kid:(NSString *)kid
                                    type:(NSString *)type
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

//地址： API/index.php?action=Kaoshi&do=addUserDn
//参数： uid 用户id
//返回： {code:code , msg:msg , data:题库列表}
//返回字段描述：
//code: 1 接口调用成功，其他表示异常
//msg: 消息提示
+ (void)requestExaminationSubmitWithUid:(NSString *)uid
                                    kid:(NSString *)kid
                                   data:(NSArray *)data
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;


//地址： API/index.php?action=Kaoshi&do=getMyKaoshi
//参数： uid
//page
//num 每一页多少条数
//返回： {code:code , msg:msg ,data:data }
//返回字段描述：
//code: 1 接口调用成功，其他表示异常
//msg: 消息提示
+ (void)requestMyExaminationWithUid:(NSString *)uid
                               page:(NSNumber *)page
                                num:(NSNumber *)num
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

@end
