//
//  WLVODCourseListViewController.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/27.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "BaseViewController.h"
#import "WLFilterView.h"

@interface WLVODCourseListViewController : BaseViewController

@property (nonatomic, strong) WLFilterView *filterView;
@property (nonatomic, strong) NSArray *courses;
@property (nonatomic, strong) NSArray *filterArray;
@property (nonatomic, strong) NSString *saleNumOrder;         // 销量
@property (nonatomic, strong) NSString *priceOrder;
@property (nonatomic, strong) NSString *sortId;

@end
