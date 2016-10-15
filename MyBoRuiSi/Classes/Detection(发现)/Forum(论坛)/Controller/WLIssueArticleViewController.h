//
//  WLIssueArticleViewController.h
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "BaseViewController.h"
#import "ZGArticleModel.h"

typedef NS_ENUM(NSUInteger, EditType) {
    EditTypeIssue = 1,
    EditTypeEdit
};

@interface WLIssueArticleViewController : BaseViewController

@property (nonatomic, strong) ZGArticleViewModel *articleViewModel;
@property (nonatomic, assign) EditType type;
@property (nonatomic, strong) NSString *circleId;

@end
