//
//  WLInputBagPwdView.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/19.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLInputBagPwdView.h"

@implementation WLInputBagPwdView

+ (instancetype)inputBagPawdView{
    return [[[NSBundle mainBundle] loadNibNamed:@"WLInputBagPwdView" owner:nil options:nil] lastObject];
}

@end
