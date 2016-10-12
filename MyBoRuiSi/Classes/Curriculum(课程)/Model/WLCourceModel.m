//
//  WLCourceModel.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCourceModel.h"

@implementation WLOtherCourseModel

@end

@implementation WLCommentModel

@end

@implementation WLCourceModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"comment" : [WLCommentModel class],
             @"other"   : [WLOtherCourseModel class]};
}

@end
