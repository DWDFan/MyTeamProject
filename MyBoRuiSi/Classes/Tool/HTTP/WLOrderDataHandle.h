//
//  WLOrderDataHandle.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLOrderDataHandle : NSObject
/**
 *  加入购物车
 *
 *  @param uid     用户ID
 *  @param goodid     商品Id
 *  @param success
 *  @param failure
 */
+ (void)requestAddCartWithUid:(NSString *)uid
                           goodid:(NSString *)goodid
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  获取购物车
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 
{
    code = 1;
    data =     (
                {
                    disPrice = 30;
                    gid = 2;
                    id = 5;
                    jiangshi = 1;
                    lose = 0;
                    name = "php\U5165\U95e8";
                    photo = "http://img.mukewang.com/529dc3380001379906000338-240-135.jpg";
                    price = 40;
                    status = 0;
                    vipFree = 1;
                }
                );
    msg = ok;
}
 */
+ (void)requestGetCartWithUid:(NSString *)uid
                       page:(NSNumber *)page
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

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
                      failure:(void (^)(NSError *error))failure;

/**
 *  获取完成支付订单
 *
 *  @param uid     用户ID
 *  @param page     页码
 *  @param success
 *  @param failure
 */
+ (void)requestGetPayedWithUid:(NSString *)uid
                            page:(NSNumber *)page
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

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
                       failure:(void (^)(NSError *error))failure;

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
                     failure:(void (^)(NSError *error))failure;
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
                          failure:(void (^)(NSError *error))failure;
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
                       failure:(void (^)(NSError *error))failure;
/**
 *  调用charge地址
 *
 *  @param uid     用户ID
 *  @param channel     支付渠道
 *  @param amount     金额/多少分钱
 *  @param success
 *  @param failure
 */
+ (void)requestAddCartWithUid:(NSString *)uid
                       channel:(NSString *)channel
                       amount:(NSString *)amount
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  提交订单
 *
 *  @param uid     用户ID
 *  @param cid     购物车货物id
 *  @param type     类型 kecheng , vip ,jifen
 *  @param type     使用多少积分
 *  @param success
 *  @param failure
 {
    code = 1;
    id = 8; //订单id
    msg = ok;
 }
 */
+ (void)requestCommitOrderWithUid:(NSString *)uid
                          cid:(NSString *)cid
                         type:(NSString *)type
                        jifen:(NSNumber *)jifen
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  订单详情
 *
 *  @param uid     用户ID
 *  @param oid     订单id
 *  @param success
 *  @param failure
 */
+ (void)requestGetOrderDetailWithUid:(NSString *)uid
                           oid:(NSString *)oid
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;
 
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
                          failure:(void (^)(NSError *error))failure;
@end
