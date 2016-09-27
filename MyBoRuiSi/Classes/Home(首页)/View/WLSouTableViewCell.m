//
//  WLSouTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSouTableViewCell.h"

@implementation WLSouTableViewCell

- (void)setInstitution:(WLInstitutionModel *)institution
{
    _institution = institution;
    
    [_photoImgV sd_setImageWithURL:[NSURL URLWithString:institution.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    _nameLbl.text = institution.name;
    
    _descLbl.text = institution.desc;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
