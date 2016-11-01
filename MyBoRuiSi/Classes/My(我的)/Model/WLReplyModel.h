//
//  WLReplyModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLReplyModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *reply;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *addtime;
@end
/*
 id = 99;
 name = "fuck dog";
 photo = "https://avatars.githubusercontent.com/u/4279697?v=3&s=120";
 reply = " \U6211\U662f\U56de\U590d";
 title = "\U554a\U554a\U554a\U554a\U554a";
 "addtime": 发布时间
*/
