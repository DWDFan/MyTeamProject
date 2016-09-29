//
//  WLMyTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyTableViewCell.h"

#import "WLUserInfo.h"
@interface WLMyTableViewCell()

@end

@implementation WLMyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)pushLoginVC:(UITapGestureRecognizer *)sender {
    if (self.tapHeaderBlock) {
        self.tapHeaderBlock();
    }
}
- (IBAction)ScClik:(id)sender {
    if (self.colletionActionBlock) {
        self.colletionActionBlock();
    }
}

@end



@interface WLUserLoginstatusCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *vip_Imv;
@property (weak, nonatomic) IBOutlet UIButton *vip_btn;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *collectionCount;

@end
@implementation WLUserLoginstatusCell
- (void)awakeFromNib {
    _vip_btn.layer.masksToBounds = YES;
    _vip_btn.layer.cornerRadius = 3;
    
    _name.text = [WLUserInfo share].nickname;
    _score.text = [[WLUserInfo share].score stringValue];
    _collectionCount.text = [[WLUserInfo share].favNum stringValue];
    
    if ([WLUserInfo share].isVip) {
        _vip_Imv.image = [UIImage imageNamed:@"icon-is会员"];
    }else{
        _vip_Imv.image = [UIImage imageNamed:@"icon-会员"];
    }
}
- (IBAction)pushPersonalDataVC:(UITapGestureRecognizer *)sender {
    if (self.tapHeaderBlock) {
        self.tapHeaderBlock();
    }
}

- (IBAction)colletionAction:(UIButton *)sender {
    if (self.colletionActionBlock) {
        self.colletionActionBlock();
    }
}

@end