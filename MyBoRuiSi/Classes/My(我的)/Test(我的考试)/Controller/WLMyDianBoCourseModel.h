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
@property (nonatomic, copy) NSString *jianjie;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *xx_num;
@property (nonatomic, strong) NSNumber *vip_free;
@end
/*
id 课程id
photo 头像
name 课程名字
jiangshi 讲师
period 有效期
  price = 1000;
dis_price 折扣价
xx_num 学习人数
vip_free vip是否免费
jianjie = "\U8bfe\U7a0b\U7b80\U4ecb";
*/
/*
 "dis_price" = 999;
 id = 7;
 jiangshi = 2;
 jianjie = "\U8bfe\U7a0b\U7b80\U4ecb";
 name = "nodejs\U76f4\U64ad";
 period = "<null>";
 photo = "http://img.mukewang.com/576b7c04000144dc06000338-240-135.jpg";
 price = 1000;
 "vip_free" = 0;
 "xx_num" = 444;
 */
