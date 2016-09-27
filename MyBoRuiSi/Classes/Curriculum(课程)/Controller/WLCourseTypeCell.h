//
//  WLCourseTypeCell.h
//  MyBoRuiSi
//
//  Created by Catski on 16/9/26.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCourseTypeCell : UITableViewCell

@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, copy) void(^block)(NSInteger index);

@end
