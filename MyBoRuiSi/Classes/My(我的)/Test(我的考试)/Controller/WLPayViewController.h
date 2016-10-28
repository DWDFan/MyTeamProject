//
//  WLPayViewController.h
//  MyBoRuiSi
//
//  Created by mo on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WLSetupPwpType) {
    WLSetupPwpTypeSetup,//设置密码
    WLSetupPwpTypeForget//忘记密码
};
@interface WLPayViewController : UIViewController
@property (nonatomic, assign) WLSetupPwpType type;

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *code;
@end
