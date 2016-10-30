//
//  WLSharetowViewController.h
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLSharetowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *wechatTimelineBtn;
@property (weak, nonatomic) IBOutlet UIView *WechatSession;
@property (weak, nonatomic) IBOutlet UIView *qqBtn;
@property (weak, nonatomic) IBOutlet UIView *qZone;
@property (weak, nonatomic) IBOutlet UIView *sinaBtn;

@property (strong, nonatomic) NSString *shareTitle;
@property (strong, nonatomic) NSString *descStr;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *webpageUrl;

@end
