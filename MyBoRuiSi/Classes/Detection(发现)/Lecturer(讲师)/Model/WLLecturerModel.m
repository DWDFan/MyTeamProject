//
//  WLLecturerModel.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLecturerModel.h"

@implementation WLCourseListModel

@end

@implementation WLLecturerModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list":[WLCourseListModel class]};
}

@end
