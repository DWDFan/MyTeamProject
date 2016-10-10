//
//  WLCirCleCell.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCirCleCell : UITableViewCell

@property (nonatomic, strong) NSArray *circlesArray;
@property (nonatomic, copy) void(^block)(NSString *typeId, NSString *name);

+ (CGFloat)heightWithCount:(NSInteger)count;

@end
