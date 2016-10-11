//
//  WLCourseWareCell.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCourseWareCell.h"

@implementation WLCourseWareCell

- (void)setCoursewareDic:(NSDictionary *)coursewareDic
{
    _coursewareDic = coursewareDic;
    
    _nameLbl.text = coursewareDic[@"kjName"];
    
    _sizeLbl.text = [NSString stringWithFormat:@"%@M",coursewareDic[@"kjSize"]];
}
- (IBAction)viewBtnAction:(id)sender {
    
    
}
- (IBAction)downloadBtnAction:(id)sender {
    
    
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
