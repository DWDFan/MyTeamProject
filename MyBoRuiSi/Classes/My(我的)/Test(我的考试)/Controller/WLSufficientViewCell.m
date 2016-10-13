//
//  WLSufficientViewCell.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSufficientViewCell.h"

@implementation WLSufficientViewCell


- (IBAction)TopButton:(id)sender {
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
