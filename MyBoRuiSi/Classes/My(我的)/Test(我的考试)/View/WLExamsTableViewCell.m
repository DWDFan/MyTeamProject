//
//  WLExamsTableViewCell.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLExamsTableViewCell.h"
#import "WLMyTestModel.h"
@interface WLExamsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *score_lab;
@property (weak, nonatomic) IBOutlet UILabel *addtime_lab;

@end

@implementation WLExamsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setModel:(WLMyTestModel *)model{
    _model = model;
    
    _title_lab.text = model.name;
    if (model.status == 0) {
        _score_lab.textColor = COLOR_WORD_GRAY_1;
        _score_lab.text = @"审批中...";
    }else {
        _score_lab.text = [NSString stringWithFormat:@"%@分",[MOTool getNULLString:model.score]];
        _score_lab.textColor = kColor_button_bg;
    }
    _addtime_lab.text = [NSString stringWithFormat:@"考试时间:%@",[MOTool getNULLString:model.starttime]];
    [_imv sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
}
- (IBAction)lookAnswerAction:(UIButton *)sender {
    !self.lookAnswerBlock ?: self.lookAnswerBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
/*
 {
	starttime = 2017-01-08 17:39:59;
	uid = 15;
	ksid = 1;
	id = 10;
	score = 0;
	status = 0;
	photo = http://brs.yerhu.com/admin/img/avatar.jpg;
	kid = 16;
	name = 考试名字;
 }
 */
