//
//  WLOrderDetailModel.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderDetailModel.h"

@implementation WLOrderDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"source" : [WLOrderSourceModel class]
             };
}
@end


@implementation WLOrderSourceModel

@end
