//
//  WLMyTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLMyTableViewCell : UITableViewCell




@property (nonatomic,copy)  void(^tapHeaderBlock)();
@property (nonatomic,copy)  void(^colletionActionBlock)();

@end


@interface WLUserLoginstatusCell : UITableViewCell
@property (nonatomic,copy)  void(^tapHeaderBlock)();
@property (nonatomic,copy)  void(^colletionActionBlock)();
@end