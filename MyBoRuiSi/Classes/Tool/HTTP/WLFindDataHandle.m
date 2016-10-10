//
//  WLFindDataHandle.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLFindDataHandle.h"

@implementation WLFindDataHandle


/**
 获取讲师列表
 
 @param sort    排序类型  star 按照好评度 follow 关注量
 @param level   等级
 @param success
 @param failure
 */
+ (void)requestFindLectureListWithSort:(NSString *)sort
                                 level:(NSNumber *)level
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"sort" : [MOTool getNULLString:sort],
                            @"level" : level ? level : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=Teacher&do=getList" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取机构列表
 
 @param sort    排序类型 member 员工数 follow 关注
 @param gsType  企业性质
 @param success
 @param failure
 */
+ (void)requestFindInstitutionListWithSort:(NSString *)sort
                                    gsType:(NSString *)gsType
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"sort" : [MOTool getNULLString:sort],
                            @"gsType" : gsType ? gsType : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=Teacher&do=getJigou" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取BBS轮播图
 
 @param success
 @param failure
 */
+ (void)requestFindBBSAdsSuccess:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Bbs&do=Ads" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 获取热贴
 
 @param success
 @param failure
 */
+ (void)requestFindBBSHotsSuccess:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Bbs&do=getHots" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 获取帖子详细数据
 
 @param tid     tid 帖子id
 @param success
 @param failure
 */
+ (void)requestFindArticleDetailWithTid:(NSString *)tid
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"id" : [MOTool getNULLString:tid],
                             @"uid" : [MOTool getNULLString:[WLUserInfo share].userId]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=postDetail" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 获取帖子回复列表
 
 @param tid     tid 帖子id
 @param page    page 页码
 @param success
 @param failure
 */
+ (void)requestFindArticleCommentListWithTid:(NSString *)tid
                                        page:(NSNumber *)page
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"tid" : [MOTool getNULLString:tid],
                            @"page" : page ? page : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=getComments" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 帖子点赞
 
 @param tid     tid 帖子id
 @param uid     uid 当前登录id
 @param success
 @param failure
 */
+ (void)requestFindArticlePriseWithTid:(NSString *)tid
                                   uid:(NSString *)uid
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"tid" : [MOTool getNULLString:tid],
                            @"uid" : [MOTool getNULLString:uid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=zanPost" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 帖子浏览
 
 @param tid     tid 帖子id
 @param uid     uid 当前登录id
 @param success
 @param failure
 */
+ (void)requestFindArticleReadWithTid:(NSString *)tid
                                  uid:(NSString *)uid
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"tid" : [MOTool getNULLString:tid],
                            @"uid" : [MOTool getNULLString:uid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=viewPost" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 收藏帖子
 
 @param tid     tid 帖子id
 @param uid     uid 当前登录id
 @param success
 @param failure
 */
+ (void)requestFindArticleCollectWithTid:(NSString *)tid
                                     uid:(NSString *)uid
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"tid" : [MOTool getNULLString:tid],
                            @"uid" : [MOTool getNULLString:uid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=favPost" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 举报帖子
 
 @param tid     tid 帖子id
 @param uid     uid 当前登录id
 @param msg     msg 举报原因
 @param success
 @param failure
 */
+ (void)requestFindArticleReportWithTid:(NSString *)tid
                                    uid:(NSString *)uid
                                    msg:(NSString *)msg
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"tid" : [MOTool getNULLString:tid],
                            @"uid" : [MOTool getNULLString:uid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=jubao" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 发布帖子
 
 @param qid     qid 圈子id
 @param uid     uid 当前登录id
 @param title   title 帖子标题
 @param content content 帖子内容
 @param pics    pics 帖子图片地址，多个用|链接
 @param success
 @param failure
 */
+ (void)requestFindArticleIssueWithQid:(NSString *)qid
                                   uid:(NSString *)uid
                                 title:(NSString *)title
                               content:(NSString *)content
                                  pics:(NSString *)pics
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"qid" : [MOTool getNULLString:qid],
                            @"uid" : [MOTool getNULLString:uid],
                            @"title" : [MOTool getNULLString:title],
                            @"content" : [MOTool getNULLString:content],
                            @"pics" : [MOTool getNULLString:pics]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=addPost" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 修改帖子
 
 @param qid     qid 圈子id
 @param uid     uid 当前登录id
 @param title   title 帖子标题
 @param content content 帖子内容
 @param pics    pics 帖子图片地址，多个用|链接
 @param tid     tid 帖子id
 @param success
 @param failure
 */
+ (void)requestFindArticleEditWithQid:(NSString *)qid
                                  uid:(NSString *)uid
                                title:(NSString *)title
                              content:(NSString *)content
                                 pics:(NSString *)pics
                                  tid:(NSString *)tid
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"qid" : [MOTool getNULLString:qid],
                            @"uid" : [MOTool getNULLString:uid],
                            @"title" : [MOTool getNULLString:title],
                            @"content" : [MOTool getNULLString:content],
                            @"pics" : [MOTool getNULLString:pics],
                            @"tid":[MOTool getNULLString:tid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=editPost" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 我的帖子
 
 @param uid     uid 当前登录id
 @param success
 @param failure
 */
+ (void)requestFindMyArticleWithUid:(NSString *)uid
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"uid" : [MOTool getNULLString:uid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=myPost" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 获取兴趣圈的列表
 
 @param success
 @param failure
 */
+ (void)requestFindCircleListSuccess:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure
{
    [MOHTTP GET:@"API/index.php?action=Bbs&do=quan" parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 获取我的兴趣圈
 
 @param uid     uid 当前登录id
 @param success
 @param failure
 */
+ (void)requestFindMyCircleWithUid:(NSString *)uid
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"uid" : [MOTool getNULLString:uid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=myQuan" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取圈子信息
 
 @param qid     qid 圈子id
 @param uid     uid 当前登录id
 @param success
 @param failure
 */
+ (void)requestFindCircleInfoWithQid:(NSString *)qid
                                 uid:(NSString *)uid
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"qid" : [MOTool getNULLString:qid],
                            @"uid" : [MOTool getNULLString:uid]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=getQuanInfo" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取圈子帖子
 
 @param qid     qid 圈子id
 @param page    第几页
 @param success
 @param failure
 */
+ (void)requestFindCircleArticleWithQid:(NSString *)qid
                                   page:(NSNumber *)page
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"qid" : [MOTool getNULLString:qid],
                            @"page" : page ? page : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=getQuanPosts" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 关注圈子
 
 @param qid     圈子id
 @param uid     当前登录id
 @param type    1 添加关注 2 取消关注
 @param success
 @param failure
 */
+ (void)requestFindCircleFollowWithQid:(NSString *)qid
                                   uid:(NSString *)uid
                                  type:(NSNumber *)type
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"qid" : [MOTool getNULLString:qid],
                            @"uid" : [MOTool getNULLString:uid],
                            @"type" : type ? type : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=Bbs&do=focusQuan" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
