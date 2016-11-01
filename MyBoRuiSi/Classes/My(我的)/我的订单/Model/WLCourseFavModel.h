//
//  WLCourseFavModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/13.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCourseFavModel : NSObject
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *disPrice;
@property (nonatomic, strong) NSNumber *vipFree;
@property (nonatomic, copy) NSString *zhujiang;
@property (nonatomic, copy) NSString *studyNum;
@property (nonatomic, copy) NSString *publicTime;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, copy) NSString *id;
@end
/*
photo 头像
name 名字
price 价格
disPrice 打折价
vipFree vip是否免费
zhujiang 主讲
studyNum 已经学习的人数
id id
*/
