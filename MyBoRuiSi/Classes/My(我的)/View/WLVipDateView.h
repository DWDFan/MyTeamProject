//
//  WLVipDateView.h
//  MyBoRuiSi
//
//  Created by Beelin on 2016/10/24.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLVipDateView : UIView
@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) void(^cancleBlock)();
@property (nonatomic, copy) void(^keepBlock)();
@end
