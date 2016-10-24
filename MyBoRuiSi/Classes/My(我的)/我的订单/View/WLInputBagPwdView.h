//
//  WLInputBagPwdView.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/19.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLInputBagPwdView : UIView
+ (instancetype)inputBagPawdView;

@property (nonatomic, copy) void(^closeBlock)();
@property (nonatomic, copy) void(^forgetPwdBlock)();
@property (nonatomic, copy) void(^completeBlock)();
@end
