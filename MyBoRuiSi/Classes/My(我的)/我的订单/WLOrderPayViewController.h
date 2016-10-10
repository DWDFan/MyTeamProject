//
//  WLOrderPayViewController.h
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger) {
    orderPayType,//订单支付
    rechargeType //充值
}payType;
@interface WLOrderPayViewController : UIViewController
@property (nonatomic, copy) NSString *orderName;  //订单名称
@property (nonatomic, strong) NSString *amountStr;
@property (nonatomic, copy) NSString *needMoney;
@property (nonatomic, copy) NSString *orderId; //订单id
@property (nonatomic, assign) payType type;
@end
