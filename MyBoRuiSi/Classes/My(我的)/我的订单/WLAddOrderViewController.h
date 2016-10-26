//
//  WLAddOrderViewController.h
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLAddOrderViewController : UIViewController
@property (nonatomic, assign) float money;//小计
@property (nonatomic, copy) NSString *type; //类型 kecheng , vip ,jifen
@property (nonatomic, strong) NSArray *dataSource;
@end
