//
//  WLCourceModel.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//name 课程名字
//photo 课程图片
//price 课程价格
//disPrice 折扣价格
//author 发布作者
//period 有效期
//desc 描述
//cmtNum 评论条数
//comment 课程评价列表，其数据字段如下：
//author 评论者
//date 评论时间
//star 几颗星
//msg 评论消息

//name 直播名字
//photo 直播图片
//id 直播id
//author 直播作者
//starttm 开始时间
//endtm 结束时间
//bm 报名人数
//limit 名额限制
//cmtNum 评论数
//comment 评论列表
//other 其他课程


#import <Foundation/Foundation.h>

@interface WLCommentModel : NSObject

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *msg;

@end


@interface WLCourceModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *disPrice;
@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *period;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *cmtNum;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSNumber *zbStatus;
@property (nonatomic, strong) NSArray<WLCommentModel *> *comment;

@property (nonatomic, assign) BOOL vipFree;
@property (nonatomic, assign) BOOL canBuy;

@property (nonatomic, strong) NSString *endtm;
@property (nonatomic, strong) NSString *starttm;
@property (nonatomic, strong) NSString *zhibotm;
@property (nonatomic, strong) NSString *publicTime;
@property (nonatomic, strong) NSNumber *bm;
@property (nonatomic, strong) NSNumber *limit;
@property (nonatomic, strong) NSArray *other;

@end


