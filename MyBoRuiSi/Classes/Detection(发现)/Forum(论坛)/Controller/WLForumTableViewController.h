//
//  WLForumTableViewController.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLForumTableViewController : UITableViewController

@property (nonatomic, assign) int tableNum;


//保存内容数组
@property (nonatomic,strong) NSMutableArray *array;

@end
