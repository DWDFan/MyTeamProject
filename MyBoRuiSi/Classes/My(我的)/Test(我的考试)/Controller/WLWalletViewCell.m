//
//  WLWalletViewCell.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLWalletViewCell.h"
@interface WLWalletViewCell()

@property (weak, nonatomic) IBOutlet UILabel *balance_label;

@end
@implementation WLWalletViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _balance_label.text = [NSString stringWithFormat:@"%@",[WLUserInfo share].money];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
