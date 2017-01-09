//
//  WLSubmitSureView.h
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/9.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLSubmitSureView : UIView

- (void)showWithBlock:(void(^)(NSInteger index))block;

@end
