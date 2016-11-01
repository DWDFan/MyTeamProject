//
//  WLMyZhiBoCourseModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/13.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLMyZhiBoCourseModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *jiangshi;
@property (nonatomic, copy) NSString *star;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *dis_price;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *publictime;
@end
/*
 id 课程id
 photo 头像
 name 课程名字
 jiangshi 讲师
 star 几颗星
 dis_price 折扣价
 price
 status 状态
 publictime 开始时间
*/

