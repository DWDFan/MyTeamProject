//
//  WLOrderCell.h
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLShopCarModel.h"
typedef void(^ClickRecharge)();//充值

@interface WLOrderCell : UITableViewCell


@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,copy) ClickRecharge action_pay;
@property (nonatomic, copy) void(^selectBalanceBlock)(NSInteger price,BOOL isSelect, NSString *cid);
@property (nonatomic, copy) void(^payBlock)(NSInteger price);

@property (nonatomic, strong) WLShopCarModel *shopCarModel;

@end
