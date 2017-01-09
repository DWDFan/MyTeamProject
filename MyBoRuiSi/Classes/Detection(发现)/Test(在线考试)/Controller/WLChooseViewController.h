//
//  WLChooseViewController.h
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/8.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLExamBaseViewController.h"

@interface WLChooseViewController : WLExamBaseViewController

@property (nonatomic, strong) NSString *kid;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *questionArray;


@end
