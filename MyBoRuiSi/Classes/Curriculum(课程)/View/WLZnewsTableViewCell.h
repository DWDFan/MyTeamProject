//
//  WLZnewsTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCourceModel.h"

@interface WLZnewsTableViewCell : UITableViewCell

@property (nonatomic, strong) WLCourceModel *course;
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *authorLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIButton *liveStatusImgV;
@property (weak, nonatomic) IBOutlet UIButton *joinNumLbl;

@end
