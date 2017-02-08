//
//  WLInstitutionModel.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/22.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLLecturerModel.h"

@interface WLGoodTeacherModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;

@end

@interface WLInstitutionModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSNumber *star;
@property (nonatomic, strong) NSNumber *kc_num;
@property (nonatomic, strong) NSNumber *js_num;
@property (nonatomic, strong) NSNumber *xy_num;
@property (nonatomic, strong) NSNumber *gz_num;
@property (nonatomic, strong) NSNumber *gs_num;
@property (nonatomic, strong) NSNumber *jr_num;
@property (nonatomic, strong) NSNumber *member;

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray<WLGoodTeacherModel *> *goodTeacher;
@property (nonatomic, strong) NSArray<WLCourseListModel *> *list;
@property (nonatomic, assign) BOOL isfollow;
@property (nonatomic, assign) BOOL isJoin;

@property (nonatomic, strong) NSMutableAttributedString *descAttrString;
@property (nonatomic, assign) CGFloat descHeight;

@end
