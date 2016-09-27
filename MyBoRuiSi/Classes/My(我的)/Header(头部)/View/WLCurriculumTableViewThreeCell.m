//
//  WLCurriculumTableViewThreeCell.m
//  MyBoRuiSi
//
//  Created by 莫 on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCurriculumTableViewThreeCell.h"

@implementation WLCurriculumTableViewThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)button_main:(id)sender {
    
    if (_WLCurriculumTableViewThreeCellblock) {
        _WLCurriculumTableViewThreeCellblock();
    }
    
}

@end
