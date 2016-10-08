//
//  WLSortSelectView.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLSortSelectViewDelegate <NSObject>

- (void)selectViewDidselectedItem:(UIButton *)button;

@end

@interface WLSortSelectView : UIView

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, assign) id<WLSortSelectViewDelegate> delegate;

@end
