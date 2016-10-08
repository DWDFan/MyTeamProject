//
//  RecommendModell.h
//  MyBoRuiSi
//
//  Created by mo on 16/8/19.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModell : NSObject

@property (nonatomic, strong)NSString *star;  //几颗星
@property (nonatomic, strong)NSString *city;  //城市
@property (nonatomic, strong)NSString *follow;//关注数
@property (nonatomic, strong)NSString *id;    //返回ID
@property (nonatomic, strong)NSString *member;//会员数
@property (nonatomic, strong)NSNumber *level; //级别
@property (nonatomic, strong)NSString *photo; //图片
@property (nonatomic, strong)NSString *name;  //名字

@end
