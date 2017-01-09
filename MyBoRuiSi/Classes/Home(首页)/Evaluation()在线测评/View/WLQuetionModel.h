//
//  WLQuetionModel.h
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/6.
//  Copyright © 2017年 itcast.com. All rights reserved.
//
//"id": "1",
//"tid": "1",
//"title": "如下哪些是现象会产生静电\\n",
//"type": "select",
//"xuanze": [
//           {
//               "content": "A. 人在工场行走"
//           },
//           {
//               "content": "B. 用普通塑胶盒装产品"
//           },
//           {
//               "content": "C. 闪烁的日光灯"
//           },
//           {
//               "content": "D. 打开设备电源开关"
//           }
//           ]
//}

#import <Foundation/Foundation.h>

@interface WLOptionModel : NSObject

@property (nonatomic, strong) NSString *content;

@end

@interface WLQuetionModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray<WLOptionModel *> *xuanze;

@end
