//
//  WLSystemMsgModel.h
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/28.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLSystemMsgModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, assign, getter=isRead) BOOL read;
@end
/*
content = "\U4f60\U597dbrs\U4f60\U597dbrs";
date = "2016-10-27";
id = 51;
read = 0;
title = "\U4f60\U597dbrs";
*/
