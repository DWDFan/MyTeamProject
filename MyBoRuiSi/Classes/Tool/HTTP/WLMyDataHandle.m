//
//  WLMyDataHandle.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyDataHandle.h"

#import "WLCourseFavModel.h"
#import "ZGArticleModel.h"
#import "WLCostModel.h"
#import "WLMyTestModel.h"
#import "WLMyDianBoCourseModel.h"
#import "WLMyZhiBoCourseModel.h"
#import "WLMyQiYeCourseModel.h"
#import "WLMyAttentionModel.h"
#import "WLVipFeeModel.h"
@implementation WLMyDataHandle

/**
 *  获取vip价格表
 *
 *  @param uid     用户ID
 *  @param success
 *  @param failure
 */
+ (void)requestGetVipFeeWithUid:(NSString *)uid
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid};
    [MOProgressHUD show];
    [MOHTTP GET:@"API/index.php?action=Vip&do=getVipFee" parameters:param success:^(id responseObject) {
        [MOProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLVipFeeModel *model =  [WLVipFeeModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        failure(error);
    }];
}

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
                        failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"year": year};
    [MOProgressHUD show];
    [MOHTTP GET:@"API/index.php?action=Vip&do=buyVip" parameters:param success:^(id responseObject) {
        [MOProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue] == 1) {
            [MOProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
            success(responseObject[@"data"]);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        failure(error);
    }];

}

/**
 *  我的收入
 */
+ (void)requestGetMyInComeWithUid:(NSString *)uid
                             page:(NSNumber *)page
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getMyInCome" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLCostModel *model =  [WLCostModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  我的支出
 */
+ (void)requestGetMyCostWithUid:(NSString *)uid
                           page:(NSNumber *)page
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getMyCost" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
                for (NSDictionary *dict in responseObject[@"data"]) {
                    WLCostModel *model =  [WLCostModel mj_objectWithKeyValues:dict];
                    [dataSource addObject:model];
                }
                success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  用户临时加钱入口   此接口给开发者调用来加余额，用来测试的
 */
+ (void)requestAddMoneyWithUid:(NSString *)uid
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid};
    [MOHTTP GET:@"API/index.php?action=Vip&do=addMoney" parameters:param success:^(id responseObject) {
               success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}


/**
 *  获取我的系统消息
 */
+ (void)requestGetMsgWithUid:(NSString *)uid
                        page:(NSNumber *)page
                        type:(NSString *)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"type":type,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getMsg" parameters:param success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            if ([type isEqualToString:@"system"]) {
                for (NSDictionary *dict in responseObject[@"data"]) {
                   
                    
                }
                success(dataSource);
            }else{
                for (NSDictionary *dict in responseObject[@"data"]) {
                   
                }
                success(dataSource);
            }
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.localizedFailureReason];
        failure(error);
    }];

}


/**
 *  我的收藏
 */
+ (void)requestGetFavListWithUid:(NSString *)uid
                            page:(NSNumber *)page
                            type:(NSNumber *)type
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"type":type,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getFavList" parameters:param success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            if ([type isEqualToNumber:@(1)]) {
                for (NSDictionary *dict in responseObject[@"data"]) {
                    ZGArticleModel *art =  [ZGArticleModel mj_objectWithKeyValues:dict];
                    ZGArticleViewModel *artVM = [[ZGArticleViewModel alloc] init];
                    artVM.article = art;
                    [dataSource addObject:artVM];
                }
                success(dataSource);
            }else{
                for (NSDictionary *dict in responseObject[@"data"]) {
                    WLCourseFavModel *tzModel =  [WLCourseFavModel mj_objectWithKeyValues:dict];
                    [dataSource addObject:tzModel];
                }
                success(dataSource);
            }
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
            failure(nil);
        }
       
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.localizedFailureReason];
        failure(error);
    }];
}

/**
 *  获取我的试卷
 */
+ (void)requestGetMyTestWithUid:(NSString *)uid
                           page:(NSNumber *)page
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getMyTest" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLMyTestModel *model =  [WLMyTestModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  获取我的点播课程
 */
+ (void)requestGetMyCourseWithUid:(NSString *)uid
                             page:(NSNumber *)page
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=myKecheng" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLMyDianBoCourseModel *model =  [WLMyDianBoCourseModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                         failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=myZhiboKc" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLMyZhiBoCourseModel *model =  [WLMyZhiBoCourseModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                          failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=myQiyeKc" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLMyQiYeCourseModel *model =  [WLMyQiYeCourseModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  获取我的帖子
 */
+ (void)requestGetMyPostWithUid:(NSString *)uid
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid};
    [MOHTTP GET:@"API/index.php?action=Bbs&do=myPost" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                ZGArticleModel *art =  [ZGArticleModel mj_objectWithKeyValues:dict];
                ZGArticleViewModel *artVM = [[ZGArticleViewModel alloc] init];
                artVM.article = art;
                [dataSource addObject:artVM];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/**
 *  删除我的帖子
 */
+ (void)requestDeleteMyPostWithUid:(NSString *)uid
                               tid:(NSString *)tid
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid};
    [MOHTTP GET:@"API/index.php?action=Bbs&do=myPost" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            success(nil);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  获取我的关注讲师列表
 */
+ (void)requestGetMyFollowJsWithUid:(NSString *)uid
                               page:(NSNumber *)page
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getMyFollowJs" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLMyAttentionModel *model =  [WLMyAttentionModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  获取我的关注机构列表
 */
+ (void)requestGetMyFollowJgWithUid:(NSString *)uid
                               page:(NSNumber *)page
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getMyFollowJg" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSMutableArray *dataSource = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                WLMyAttentionModel *model =  [WLMyAttentionModel mj_objectWithKeyValues:dict];
                [dataSource addObject:model];
            }
            success(dataSource);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  修改个人资料

 */
+ (void)requestUpdateInfoWithUid:(NSString *)uid
                             key:(NSString *)key
                             val:(NSString *)val
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"key":key,
                            @"val":val};
    [MOProgressHUD show];
    [MOHTTP GET:@"API/index.php?action=User&do=updateInfo" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [MOProgressHUD showSuccessWithStatus:@"修改成功"];
            success(responseObject);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.localizedFailureReason];
        failure(error);
    }];
    
}

/**
 *  设置支付密码
 */
+ (void)requestSetPwdWithUid:(NSString *)uid
                         pwd:(NSString *)pwd
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"pwd":pwd};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=setPwd" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [MOProgressHUD showSuccessWithStatus:@"设置成功"];
            [WLUserInfo share].bagPwd = @1;
            [[WLUserInfo share] reArchivUserInfo];
            success(responseObject);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
         [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        failure(error);
    }];

}
/**
 *  修改我的钱包密码
 */
+ (void)requestUpdatePwdWithUid:(NSString *)uid
                         oldpwd:(NSString *)oldpwd
                            pwd:(NSString *)pwd
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"oldpwd":oldpwd,
                             @"pwd":pwd};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=updatePwd" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            success(responseObject);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        failure(error);
    }];

}

/**
 *  验证我的钱包密码
 */
+ (void)requestCheckPwdWithUid:(NSString *)uid
                           pwd:(NSString *)pwd
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"pwd":pwd};
    [MOProgressHUD show];
    [MOHTTP GET:@"API/index.php?action=UCenter&do=checkPwd" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [MOProgressHUD dismiss];
            success(responseObject);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
         [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        failure(error);
    }];
}

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
                        failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"telphone":telphone,
                            @"code":code,
                            @"pwd":pwd};
    [MOProgressHUD show];
    [MOHTTP GET:@"API/index.php?action=UCenter&do=forgetPwd" parameters:param success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [MOProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
            success(responseObject);
        }else {
            [MOProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        failure(error);
    }];

}
@end
