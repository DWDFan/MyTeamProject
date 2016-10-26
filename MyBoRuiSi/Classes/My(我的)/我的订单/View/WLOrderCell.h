//
//  WLOrderCell.h
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLShopCarModel.h"
typedef NS_ENUM(NSInteger,WLOrderCellType) {
    shopCarType,waitPayType,completePayType,colseOrderType
};
typedef void(^ClickRecharge)();//充值

@interface WLOrderCell : UITableViewCell


@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,copy) ClickRecharge action_pay;
@property (nonatomic, assign) WLOrderCellType cellType;
@property (nonatomic, copy) void(^selectBalanceBlock)(NSInteger price,BOOL isSelect, WLShopCarModel *shopCarModel);//购物车模块 的 结算按钮block
@property (nonatomic, copy) void(^selectDeleteBlock)(BOOL isSelect, NSString *oid);  //关闭订单模块 的 删除按钮block
@property (nonatomic, copy) void(^payBlock)(NSInteger price);

@property (nonatomic, copy) NSString *oid;//只为 selectDeleteBlock 而设计
@property (nonatomic, strong) WLShopCarModel *shopCarModel;

@end
