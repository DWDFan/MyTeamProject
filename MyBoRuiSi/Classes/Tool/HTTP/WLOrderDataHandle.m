//
//  WLOrderDataHandle.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderDataHandle.h"

@implementation WLOrderDataHandle
/**
 *  加入购物车
 */
+ (void)requestAddCartWithUid:(NSString *)uid
                       goodid:(NSString *)goodid
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid, @"goodid":goodid};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=addCart" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  获取购物车
 */
+ (void)requestGetCartWithUid:(NSString *)uid
                         page:(NSNumber *)page
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid, @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getCart" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  获取我待支付
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetWaitPayWithUid:(NSString *)uid
                            page:(NSNumber *)page
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=waitPay" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  调用charge地址
 */
+ (void)requestAddCartWithUid:(NSString *)uid
                      channel:(NSString *)channel
                       amount:(NSString *)amount
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid, @"channel":channel, @"amount":amount};
    [MOHTTP Post:@"API/pingjj/example/pay.php" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  提交订单
 */
+ (void)requestCommitOrderWithUid:(NSString *)uid
                              cid:(NSString *)cid
                             type:(NSString *)type
                            jifen:(NSString *)jifen
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"cid":cid,
                            @"type":type,
                            @"jifen":jifen ? jifen : [NSNull null]
                            };
    [MOHTTP GET:@"API/index.php?action=UCenter&do=addOrder" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  确认支付
 *
 *  @param uid     用户ID
 *  @param oid     订单id
 *  @param success
 *  @param failure
 */
+ (void)requestDopayWithUid:(NSString *)uid
                              oid:(NSString *)oid
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"oid":oid,
                            };
    [MOHTTP GET:@"API/index.php?action=UCenter&do=doPay" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
