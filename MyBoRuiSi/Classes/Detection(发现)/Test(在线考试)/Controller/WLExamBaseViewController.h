//
//  WLExamBaseViewController.h
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/9.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WLExaminationHelper.h"

@interface WLExamBaseViewController : BaseViewController <UIAlertViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) WLExaminationHelper *examHelper;
@property (nonatomic, assign) BOOL isShowAnswer;     // 查答案

@end
