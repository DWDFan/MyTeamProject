//
//  WLOrderCell.h
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLOrderModel.h"
typedef void(^ClickRecharge)();//充值

@interface WLOrderCell : UITableViewCell


@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,copy) ClickRecharge action_pay;

@property (nonatomic, strong) WLOrderModel *orderModer;

@end
