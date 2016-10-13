//
//  WLOrderDetailModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLOrderSourceModel;
@interface WLOrderDetailModel : NSObject
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *jifen;
@property (nonatomic, copy) NSString *orderno;
@property (nonatomic, copy) NSString *realPay;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray <WLOrderSourceModel*>*source;
@end

@interface WLOrderSourceModel : NSObject
@property (nonatomic, copy) NSString *apply;
@property (nonatomic, copy) NSString *jiangshi;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *showtime;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *type;
@end
