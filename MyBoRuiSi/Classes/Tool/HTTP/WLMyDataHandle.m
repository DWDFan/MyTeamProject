//
//  WLMyDataHandle.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyDataHandle.h"

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
        success(responseObject);
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
        success(responseObject);
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
@end
