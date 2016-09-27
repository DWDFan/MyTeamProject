//
//  WLMyTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLMyTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *button_mian;


@property (nonatomic,copy)  void(^WLMyTableViewCellBlock)();

@end
