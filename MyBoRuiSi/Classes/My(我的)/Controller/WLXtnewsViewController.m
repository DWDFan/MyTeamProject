//
//  WLXtnewsViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLXtnewsViewController.h"
#import "WLreplTableViewCell.h"

#import "WLSystemMsgModel.h"
#import "WLMyDataHandle.h"
@interface WLXtnewsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *content_lab;
@property (weak, nonatomic) IBOutlet UILabel *date_lab;
@property (nonatomic, strong) WLSystemMsgModel *model;
@end

@implementation WLXtnewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"系统消息" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    //request
    [self requestGetMsgInfo];
}


//颜色转图片
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return theImage;
}

#pragma mark - Request
- (void)requestGetMsgInfo{
    [WLMyDataHandle requestGetMsgInfoWithUid:[WLUserInfo share].userId id:self.infoId success:^(id responseObject) {
        _model = responseObject;
        _content_lab.text = self.model.content;
        _content_lab.text = self.model.date;
    } failure:^(NSError *error) {
        
    }];
}

@end
