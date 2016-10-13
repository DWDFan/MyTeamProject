//
//  WLOrderModel.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderModel.h"
#import "WLShopCarModel.h"
@implementation WLOrderModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"info" : [WLShopCarModel class]
             };
}
@end
