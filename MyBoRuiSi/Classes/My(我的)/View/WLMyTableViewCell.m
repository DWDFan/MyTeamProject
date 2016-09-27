//
//  WLMyTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyTableViewCell.h"

@implementation WLMyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)ScClik:(id)sender {
    
    //block
    if (self.WLMyTableViewCellBlock) {
        
        self.WLMyTableViewCellBlock();
    }

    
}

@end
