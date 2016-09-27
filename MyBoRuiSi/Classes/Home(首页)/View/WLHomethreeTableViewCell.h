//
//  WLHomethreeTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendationModelll.h"

@interface WLHomethreeTableViewCell : UITableViewCell

@property (nonatomic, strong)RecommendationModelll *Modelll;

//图片
@property (weak, nonatomic) IBOutlet UIImageView *pphoto;
//名字
@property (weak, nonatomic) IBOutlet UILabel *mname;
//关注量
@property (weak, nonatomic) IBOutlet UILabel *follow;
//会员量
@property (weak, nonatomic) IBOutlet UILabel *mmember;
@property (weak, nonatomic) IBOutlet UIView *starView;
@end
