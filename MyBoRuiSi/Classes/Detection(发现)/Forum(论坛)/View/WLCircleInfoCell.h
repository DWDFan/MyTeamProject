//
//  WLCircleInfoCell.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCircleModel.h"

@interface WLCircleInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *menberLbl;
@property (weak, nonatomic) IBOutlet UILabel *topicLbl;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property (nonatomic, strong) WLCircleInfoModel *circleInfo;

@property (nonatomic, copy) void(^block)(UIButton *sender);

@end
