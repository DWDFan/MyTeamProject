//
//  WLVipPriceListView.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/24.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLVipPriceListView : UIView
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) void(^cancleBlock)();
@property (nonatomic, copy) void(^buyVipBlock)(NSNumber *year);
@end
