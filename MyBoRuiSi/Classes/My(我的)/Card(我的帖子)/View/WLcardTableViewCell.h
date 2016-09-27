//
//  WLcardTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLcardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contextLbl;


@end
