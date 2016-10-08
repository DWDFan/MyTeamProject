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
@end
