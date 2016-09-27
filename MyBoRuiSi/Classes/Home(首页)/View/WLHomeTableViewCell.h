//
//  WLHomeTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//bolke
typedef void (^WLHomeTableViewCellBlock)();

@interface WLHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button_main;

@property (nonatomic,copy)  void(^WLHomeTableViewCellBlock)();
@property (nonatomic,copy)  void(^WLHomeTableViewCellBlockTwo)();
@property (nonatomic,copy)  void(^WLHomeTableViewCellBlockThree)();
@property (nonatomic,copy)  void(^WLHomeTableViewCellBlockFour)();

@end
