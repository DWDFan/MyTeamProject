//
//  WLMyCourseModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/13.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLMyDianBoCourseModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *jiangshi;
@property (nonatomic, copy) NSString *period;
@property (nonatomic, copy) NSString *dis_price;
@property (nonatomic, copy) NSString *xx_num;
@property (nonatomic, strong) NSNumber *vip_free;
@end
/*
id 课程id
photo 头像
name 课程名字
jiangshi 讲师
period 有效期
dis_price 折扣价
xx_num 学习人数
vip_free vip是否免费
*/
