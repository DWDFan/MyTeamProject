//
//  WLExamsTableViewCell.h
//  MyBoRuiSi
//
//  Created by mo on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLMyTestModel;
@interface WLExamsTableViewCell : UITableViewCell
@property (nonatomic, strong) WLMyTestModel *model;
@property (nonatomic, copy) void(^lookAnswerBlock)();
@end
