//
//  WLCircleModel.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCircleModel.h"

@implementation WLCircleModel

@end

@implementation WLcircleTypeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"child":[WLCircleSubTypeModel class]};
}

@end

@implementation WLCircleSubTypeModel



@end

@implementation WLCircleInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"icon":@"photo"};
}

@end
