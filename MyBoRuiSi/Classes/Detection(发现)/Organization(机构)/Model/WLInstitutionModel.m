//
//  WLInstitutionModel.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/22.
//  Copyright © 2016年 itcast.com. All rights reserved.
//  机构model

#import "WLInstitutionModel.h"

@implementation WLGoodTeacherModel


@end

@implementation WLInstitutionModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list" : [WLCourseListModel class],
             @"goodTeacher" : [WLGoodTeacherModel class]};
}

@end
