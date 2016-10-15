//
//  WLLecturerModel.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCourseListModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *disPrice;
@property (nonatomic, strong) NSNumber *star;
@property (nonatomic, strong) NSString *follow;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *id;

@end

@interface WLLecturerModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSNumber *star;
@property (nonatomic, strong) NSNumber *kc_num;
@property (nonatomic, strong) NSNumber *xy_num;
@property (nonatomic, strong) NSNumber *gz_num;

@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray<WLCourseListModel *> *list;
@property (nonatomic, assign) BOOL isfollow;

@end
