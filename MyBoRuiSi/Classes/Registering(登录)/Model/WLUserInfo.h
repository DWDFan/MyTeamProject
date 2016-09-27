//
//  WLUserInfo.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/21.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLUserInfo : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) BOOL isLogin;

+ (WLUserInfo *)share;

@end
