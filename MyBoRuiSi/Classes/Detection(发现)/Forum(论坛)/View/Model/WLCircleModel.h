//
//  WLCircleModel.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//
//"id": "11",
//"name": "无尘室搭建圈",
//"addtime": null,
//"pid": "4",
//"level": "0",
//"show": "1",
//"icon": "https://avatars.githubusercontent.com/u/10694243?v=3&s=120"
//"id": "4",
//"name": "净化圈",
//"desc": null,
//"level": "0",
//"show": "1",
//"child": []

//gzNum = 10;
//id = 3;
//isFollow = 0;
//name = "ESD\U4ea4\U6d41\U5708";
//photo = "http://brs.yerhu.com/admin/upload/img/1484548065_548aa904c52d6.jpg";
//tiezi = 20;


#import <Foundation/Foundation.h>

@interface WLCircleModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

@end

@interface WLcircleTypeModel : NSObject

@property (nonatomic, strong) NSArray *child;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *show;

@end

@interface WLCircleSubTypeModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *show;
@property (nonatomic, strong) NSString *icon;

@end

@interface WLCircleInfoModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *member;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, assign) BOOL isFollow;

@end
