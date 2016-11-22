//
//  WLorgTableViewCell.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLInstitutionModel.h"

@interface WLorgTableViewCell : UITableViewCell

@property (nonatomic, strong) WLInstitutionModel *institution;
@property (nonatomic, strong) void(^block)(NSString *lecturerId); 

@end
