//
//  WLCourseWareCell.h
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCourseWareCell : UITableViewCell

@property (nonatomic ,strong) NSDictionary *coursewareDic;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *sizeLbl;

@end
