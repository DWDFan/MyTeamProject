//
//  WLLookTableViewCell.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLookTableViewCell.h"
#import "AppraisalViewController.h"


@implementation WLLookTableViewCell

- (IBAction)looks:(id)sender {
    AppraisalViewController *looks = [[AppraisalViewController alloc]init];
    looks.courseId = _courseId;
    [self.nvc pushViewController:looks animated:YES];
}

//UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[QHSliderViewController sharedSliderController]];
//self.window.rootViewController = nav;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
