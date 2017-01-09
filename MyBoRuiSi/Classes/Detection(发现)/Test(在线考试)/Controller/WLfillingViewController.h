//
//  WLfillingViewController.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLExamBaseViewController.h"

@interface WLfillingViewController : WLExamBaseViewController

@property (nonatomic, strong) NSString *kid; 
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *questionArray;

@end
