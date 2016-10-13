//
//  WLCostModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/13.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCostModel : NSObject
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *addtime;
@end
/*
 data：支出明细列表，其中一条数据如下：
 action 消费动作
 price 消费金额
 date 消费日期
 addtime 消费时间
 */
