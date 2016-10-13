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
 *  获取完成支付订单
 */
+ (void)requestGetPayedWithUid:(NSString *)uid
                          page:(NSNumber *)page
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=getPayed" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  获取关闭订单
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetClosePayWithUid:(NSString *)uid
                             page:(NSNumber *)page
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"page":page};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=closePay" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 *  删除购物车
 *
 *  @param uid     用户ID
 *  @param cid     购物车id
 *  @param success
 *  @param failure
 */
+ (void)requestDelCarWithUid:(NSString *)uid
                         cid:(NSString *)cid
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"cid":cid};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=delCart" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 *  关闭订单
 *
 *  @param uid     用户ID
 *  @param oid     订单id,多个id用|连接
 *  @param success
 *  @param failure
 */
+ (void)requestDelOrderWithUid:(NSString *)uid
                           oid:(NSString *)oid
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"oid":oid};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=delOrder" parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  删除订单
 *
 *  @param uid     用户ID
 *  @param oid     订单id,多个id用|连接
 *  @param success
 *  @param failure
 */
+ (void)requestCutOrderWithUid:(NSString *)uid
                           oid:(NSString *)oid
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"oid":oid};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=cutOrder" parameters:param success:^(id responseObject) {
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
 *  订单详情
 *
 *  @param uid     用户ID
 *  @param oid     订单id
 *  @param success
 *  @param failure
 *
{
    code = 1;
    data =     {
        addtime = "2016-10-11 09:17:15";
        jifen = 0;
        orderno = 1476177435;
        realPay = 120;
        source =         (
                          {
                              apply = 10;
                              jiangshi = 1;
                              name = "php\U5165\U95e8";
                              photo = "http://img.mukewang.com/529dc3380001379906000338-240-135.jpg";
                              price = 30;
                              showtime = "<null>";
                              total = "<null>";
                              type = 1;
                          },
                          {
                              apply = 10;
                              jiangshi = 1;
                              name = "JavaScript\U5165\U95e8\U7bc7";
                              photo = "http://img.mukewang.com/53e1d0470001ad1e06000338-240-135.jpg";
                              price = 90;
                              showtime = "2016-10-01 12:12:11";
                              total = "<null>";
                              type = 1;
                          }
                          );
        status = "\U5f85\U652f\U4ed8";
        total = 120;
    };
    msg = ok;
}
*/
+ (void)requestGetOrderDetailWithUid:(NSString *)uid
                                 oid:(NSString *)oid
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"uid":uid,
                            @"oid":oid};
    [MOHTTP GET:@"API/index.php?action=UCenter&do=orderDetail" parameters:param success:^(id responseObject) {
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
        [WLUserInfo share].money = responseObject[@"data"];
        [[WLUserInfo share] reArchivUserInfo];//重新归档
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
