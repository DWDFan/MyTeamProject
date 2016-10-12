//
//  WLOrderFooterView.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLOrderModel;
@interface WLOrderFooterView : UITableViewHeaderFooterView
@property (nonatomic, copy) void(^payBlock)(NSString *oid, NSString *amount);
@property (nonatomic, copy) void(^detailBlock)(NSString *oid);
@property (nonatomic, copy) void(^deleteBlock)(NSString *oid);

@property (nonatomic, strong) WLOrderModel *orderModel;
@end
