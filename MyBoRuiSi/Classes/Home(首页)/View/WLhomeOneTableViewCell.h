//
//  WLhomeOneTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurriculumModel.h"

@interface WLhomeOneTableViewCell : UITableViewCell

@property (nonatomic,strong) CurriculumModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *Photoimage;
@property (weak, nonatomic) IBOutlet UIImageView *Photoimages;
@property (weak, nonatomic) IBOutlet UIImageView *Photoimagea;
@property (weak, nonatomic) IBOutlet UILabel *Author;
@property (weak, nonatomic) IBOutlet UILabel *Tmlong;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UILabel *disPrice;
@property (weak, nonatomic) IBOutlet UILabel *Mname;

@end
