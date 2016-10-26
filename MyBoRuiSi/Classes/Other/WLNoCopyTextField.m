//
//  WLNoCopyTextField.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/26.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLNoCopyTextField.h"

@implementation WLNoCopyTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
