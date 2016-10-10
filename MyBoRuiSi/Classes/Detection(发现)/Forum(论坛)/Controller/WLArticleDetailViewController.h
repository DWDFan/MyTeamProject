//
//  WLArticleDetailViewController.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/9.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "BaseViewController.h"
#import "ZGArticleModel.h"

@interface WLArticleDetailViewController : BaseViewController

@property (nonatomic, strong) NSString *articleId;
@property (nonatomic, strong) ZGArticleViewModel *articleViewModel;

@end
