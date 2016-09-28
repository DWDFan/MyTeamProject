//
//  WLLiveCourseTypeCell.h
//  MyBoRuiSi
//
//  Created by Catski on 16/9/28.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLLiveCourseTypeCell : UITableViewCell

@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, copy) void(^block)(NSString *typeId);

@end
