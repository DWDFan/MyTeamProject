//
//  WLInstitutionInfoCell.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/22.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLInstitutionInfoCell.h"

@interface WLInstitutionInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *courseNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *leturerNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *followNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *joinInsNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *comNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@end

@implementation WLInstitutionInfoCell

- (void)setInstitution:(WLInstitutionModel *)institution
{
    _institution = institution;
    
    _nameLbl.text = institution.name;
    
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:institution.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    
    _courseNumLbl.text = [NSString stringWithFormat:@"课程数：%@",[MOTool getNULLString:institution.kc_num]];
    
    _leturerNumLbl.text = [NSString stringWithFormat:@"讲师数：%@人",[MOTool getNULLString:institution.js_num]];
    
    _studentNumLbl.text = [NSString stringWithFormat:@"学员数：%@人",[MOTool getNULLString:institution.xy_num]];
    
    _followNumLbl.text = [NSString stringWithFormat:@"关注量：%@",[MOTool getNULLString:institution.gz_num]];
    
    _joinInsNumLbl.text = [NSString stringWithFormat:@"已加入机构：%@",[MOTool getNULLString:institution.jr_num]];
    
    _comNumLbl.text = [NSString stringWithFormat:@"公司规模：%@人",[MOTool getNULLString:institution.gs_num]];
    
    _descLbl.text = [NSString stringWithFormat:@"%@",[MOTool getNULLString:institution.desc]];
    
    _followBtn.selected = institution.isfollow;
}

- (IBAction)followBtnAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    self.block ? self.block(button) : nil;
}

@end
