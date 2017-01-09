//
//  WLPurchaseBottomView.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/23.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WLPurchaseViewStyle) {
    WLPurchaseViewStyleVOD,
    WLPurchaseViewStyleLive,
    WLPurchaseViewStyleJoinCourse
};

@interface WLPurchaseBottomView : UIView

@property (nonatomic, copy) void(^joinShopCarBlock)() ;


@property (nonatomic, copy) void(^bottomViewBLock)(NSUInteger index);

@property (nonatomic, assign) BOOL canplay;

- (instancetype)initWithFrame:(CGRect)frame style:(WLPurchaseViewStyle)style;


@end
