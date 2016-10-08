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
@end
