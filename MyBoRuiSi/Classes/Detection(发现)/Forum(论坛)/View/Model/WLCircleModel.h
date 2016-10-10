//
//  WLCircleModel.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCircleModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;

@end

@interface WLcircleTypeModel : NSObject

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *name;

@end

@interface WLCircleInfoModel : NSObject

@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *member;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, assign) BOOL isFollow;

@end
