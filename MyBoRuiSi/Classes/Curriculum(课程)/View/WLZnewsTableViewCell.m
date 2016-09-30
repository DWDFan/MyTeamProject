//
//  WLZnewsTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLZnewsTableViewCell.h"

@implementation WLZnewsTableViewCell

- (void)setCourse:(WLCourceModel *)course
{
    _course = course;
    
    
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
