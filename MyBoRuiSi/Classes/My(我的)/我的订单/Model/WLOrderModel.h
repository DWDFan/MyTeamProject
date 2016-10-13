//
//  WLOrderModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//  待付款 Model

#import <Foundation/Foundation.h>
@class WLShopCarModel;
@interface WLOrderModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSArray <WLShopCarModel *>*info;

@property (nonatomic, copy) NSString *name;
@end
