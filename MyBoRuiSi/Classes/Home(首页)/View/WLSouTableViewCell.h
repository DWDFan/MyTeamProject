//
//  WLSouTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLInstitutionModel.h"

@interface WLSouTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (strong, nonatomic) WLInstitutionModel *institution;

@end
