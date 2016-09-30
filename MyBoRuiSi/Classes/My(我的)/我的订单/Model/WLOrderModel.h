//
//  WLOrderModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLOrderModel : NSObject
@property (nonatomic, strong) NSNumber *disPrice;
@property (nonatomic, strong) NSNumber *gid;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSString *jiangshi;
@property (nonatomic, strong) NSNumber *lose;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *vipFree;
@end
/*
{
    code = 1;
    data =     (
                {
                    disPrice = 30;
                    gid = 2;
                    id = 5;
                    jiangshi = 1;
                    lose = 0;
                    name = "php\U5165\U95e8";
                    photo = "http://img.mukewang.com/529dc3380001379906000338-240-135.jpg";
                    price = 40;
                    status = 0;
                    vipFree = 1;
                }
                );
    msg = ok;
}
*/