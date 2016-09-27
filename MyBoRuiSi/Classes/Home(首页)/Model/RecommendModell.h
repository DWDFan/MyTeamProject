//
//  RecommendModell.h
//  MyBoRuiSi
//
//  Created by mo on 16/8/19.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModell : NSObject

@property (nonatomic, copy)NSString *star;  //几颗星
@property (nonatomic, copy)NSString *city;  //城市
@property (nonatomic, copy)NSString *follow;//关注数
@property (nonatomic, copy)NSString *id;    //返回ID
@property (nonatomic, copy)NSString *member;//会员数
@property (nonatomic, copy)NSString *level; //级别
@property (nonatomic, copy)NSString *photo; //图片
@property (nonatomic, copy)NSString *name;  //名字

@end
