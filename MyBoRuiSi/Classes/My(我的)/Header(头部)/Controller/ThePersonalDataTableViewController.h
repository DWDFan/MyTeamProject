//
//  ThePersonalDataTableViewController.h
//  MyBoRuiSi
//
//  Created by 莫 on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThePersonalDataTableViewController : UITableViewController
@property (nonatomic, copy) void(^reloadDataBlock)();
@end
