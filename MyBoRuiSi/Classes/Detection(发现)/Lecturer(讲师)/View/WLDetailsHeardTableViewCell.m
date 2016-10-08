//
//  WLDetailsHeardTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLDetailsHeardTableViewCell.h"

@interface WLDetailsHeardTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *courseNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *attentionNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *leverLbl;
@property (weak, nonatomic) IBOutlet UILabel *institutionLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UIImageView *starImgV1;
@property (weak, nonatomic) IBOutlet UIImageView *starImgV2;
@property (weak, nonatomic) IBOutlet UIImageView *starImgV3;
@property (weak, nonatomic) IBOutlet UIImageView *starImgV4;
@property (weak, nonatomic) IBOutlet UIImageView *starImgV5;
@property (weak, nonatomic) IBOutlet UIButton *attentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *leverImgV;

@end

@implementation WLDetailsHeardTableViewCell

- (void)setLecturer:(WLLecturerModel *)lecturer
{
    _lecturer = lecturer;
    
    _nameLbl.text = lecturer.name;
    _courseNumLbl.text = [NSString stringWithFormat:@"%@",lecturer.kc_num];
    _studentNumLbl.text = [NSString stringWithFormat:@"%@人",lecturer.xy_num];
    _attentionNumLbl.text = [NSString stringWithFormat:@"%@人",lecturer.gz_num];
    _descLbl.text = lecturer.desc;
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:lecturer.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    _attentBtn.selected = lecturer.isfollow;
    
    _leverLbl.text = @"XX机构";
    _institutionLbl.text = @"优秀教师";
}

- (IBAction)followBtnAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    self.block ? self.block(button) : nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
