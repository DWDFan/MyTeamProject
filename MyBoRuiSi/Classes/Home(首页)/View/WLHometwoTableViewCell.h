//
//  WLHometwoTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModell.h"

@interface WLHometwoTableViewCell : UITableViewCell

@property (nonatomic, strong)RecommendModell *Modell;

//图片
@property (weak, nonatomic) IBOutlet UIImageView *Phopot;
//名字
@property (weak, nonatomic) IBOutlet UILabel *name;
//级别
@property (weak, nonatomic) IBOutlet UILabel *Level;
//城市
@property (weak, nonatomic) IBOutlet UILabel *City;
//关注数
@property (weak, nonatomic) IBOutlet UILabel *Follow;
//会员数
@property (weak, nonatomic) IBOutlet UILabel *Member;

@end
