//
//  WLHomeTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLHomeTableViewCell.h"

@implementation WLHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)clickone:(UIButton *)sender {

    
    
    if (sender.tag == 1) {
        
        
        if (self.WLHomeTableViewCellBlock) {
            
            self.WLHomeTableViewCellBlock();
        }
        
    }else if (sender.tag == 2){
        
        if (self.WLHomeTableViewCellBlockTwo) {
            self.WLHomeTableViewCellBlockTwo();
        }
        
    }else if (sender.tag == 3) {
        
        if (self.WLHomeTableViewCellBlockThree) {
            self.WLHomeTableViewCellBlockThree();
        }
        
    }else{
        
        if (self.WLHomeTableViewCellBlockFour) {
            self.WLHomeTableViewCellBlockFour();
        }
        
    }
    
    
    

    
  // NSLog(@"点击%ld",(long)sender.tag);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
