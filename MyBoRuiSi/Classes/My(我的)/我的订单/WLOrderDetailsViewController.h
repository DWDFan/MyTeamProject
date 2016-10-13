//
//  WLOrderDetailsViewController.h
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WLOrderDetailType) {
    WLOrderDetailWaitPayType, WLOrderDetailPayedType, WLOrderDetailCloseType
};
@interface WLOrderDetailsViewController : UIViewController

@property (nonatomic, assign) WLOrderDetailType orderDetailType;




@property (nonatomic,copy) NSString *str_button;

@property (nonatomic, copy) NSString *oid;

@end
