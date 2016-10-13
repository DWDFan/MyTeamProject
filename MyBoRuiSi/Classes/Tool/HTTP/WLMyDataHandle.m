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
@implementation WLMyDataHandle
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
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
