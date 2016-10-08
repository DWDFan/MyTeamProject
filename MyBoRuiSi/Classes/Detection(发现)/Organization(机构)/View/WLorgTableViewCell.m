//
//  WLorgTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLorgTableViewCell.h"

@implementation WLorgTableViewCell

- (void)setInstitution:(WLInstitutionModel *)institution
{
    _institution = institution;
    
    for (int i = 0; i < 5; i ++) {
        
        UIView *lectureView = [self viewWithTag:1000 + i];
        
        if (i < _institution.goodTeacher.count) {
            
            WLGoodTeacherModel *lecture = [_institution.goodTeacher objectAtIndex:i];
            UIImageView *avatarImgV = (UIImageView *)[lectureView viewWithTag:666];
            UILabel *nameLbl = (UILabel *)[lectureView viewWithTag:777];
            [avatarImgV sd_setImageWithURL:[NSURL URLWithString:lecture.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
            nameLbl.text = lecture.name;
            lectureView.hidden = NO;
        }else {
            lectureView.hidden = YES;
        }
    }
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
