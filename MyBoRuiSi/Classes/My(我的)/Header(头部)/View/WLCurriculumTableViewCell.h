//
//  WLCurriculumTableViewCell.h
//  MyBoRuiSi
//
//  Created by 莫 on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCurriculumTableViewCell : UITableViewCell

/**
 *  跳转Block
 */
@property (nonatomic,strong) void (^WLCurriculumTableViewCellBlcok)();

@end
