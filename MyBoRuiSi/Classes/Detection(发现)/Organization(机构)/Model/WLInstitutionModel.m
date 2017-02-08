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

- (void)setDesc:(NSString *)desc
{
    _desc = desc;
    
    _descAttrString = [MOTool getAttributeStringByHtmlString:desc fontSize:12 textColor:COLOR_WORD_GRAY_1];
    
    _descHeight = [_descAttrString boundingRectWithSize:(CGSize){WLScreenW - 30, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
}

@end
