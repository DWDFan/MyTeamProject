//
//  WLjg1TableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLMyAttentionModel;
@interface WLjg1TableViewCell : UITableViewCell
@property (nonatomic, copy) void(^deleteBlock)(NSString *tid);
@property (nonatomic, strong) WLMyAttentionModel *model;
@end
