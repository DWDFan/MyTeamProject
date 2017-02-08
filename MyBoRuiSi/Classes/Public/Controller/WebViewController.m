//
//  WebViewController.m
//  Gone
//
//  Created by Happy on 15/9/16.
//  Copyright (c) 2015年 xiaowuxiaowu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController()

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation WebViewController

- (void)leftBtnAction:(UIButton *)sender
{
    [super leftBtnAction:sender];
    
    web.delegate =nil;

    if(self.isHide)
    {
        self.navigationController.navigationBarHidden = YES;
    }
    
}


//- (UIButton *)rightButton
//{
//    if (!_rightButton) {
//        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_rightButton setTitle:@"分享" forState:UIControlStateNormal];
//        [_rightButton setTitleColor:COLOR_black_33333 forState:UIControlStateNormal];
//        _rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_rightButton addTarget:self action:@selector(versionRightButtnAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _rightButton;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self iNeedALine];
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.rightBtn.userInteractionEnabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:self.titleStr forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    if (self.urlstr) {
          NSArray *httpArray = [self.urlstr componentsSeparatedByString:@"http://"];
        if (httpArray.count>2) {
            return;
        }
//        NSString * urlHead = @"http://";
//        self.urlstr = [urlHead stringByAppendingString:self.urlstr];
    }
  
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, WLScreenH - 64)];
    web.scalesPageToFit = YES;
    web.delegate = self;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstr]]];
    
    [self.view addSubview:web];
    
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
}

//- (void)versionRightButtnAction
//{
//    
//}



- (void)rightBtnAction:(id)sender
{
//    NSString *result = [web stringByEvaluatingJavaScriptFromString:@"gworld.storage.getStorage()"];
//    WLLog(@"产品列表 %@",result);
//    if([[[result JSONValue] objectForKey:@"datas"] count] > 0){
//        NSMutableDictionary *mDic = [[[result JSONValue] objectForKey:@"datas"] objectAtIndex:0];
//        self.addGoodBlock(mDic);
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"请选择产品"
//                                                           delegate:nil
//                                                  cancelButtonTitle:nil
//                                                  otherButtonTitles:@"取消",@"确定", nil];
//        [alertView show];
//    }
    
//    [Share handleShareSDKWithContent:@"" WithDefaultContent:@"" WithImage:nil WithImageURl:@"" WithTitle:@"" WithURL:@"http://ios.legacy.hk:8899/gxin/down/down.html" WithDescription:@"" WithIsImageUrl:NO];
    
//    [Share handleShareSDKCustomPlatformType:SSDKPlatformSubTypeWechatTimeline WithContent:@"" WithDefaultContent:@"" WithImage:nil WithImageURl:nil WithTitle:@"" WithURL:@"http:ios.legacy.hk:8899/gxin/down/down.html WithDescription" WithIsImageUrl:NO];
    
    
//    [Share handleShareSDKCustomPlatformType:SSDKPlatformSubTypeWechatTimeline WithContent:@"" WithDefaultContent:@"" WithImage:nil WithImageURl:@"" WithTitle:@"" WithURL:@"http://ios.legacy.hk:8899/gxin/down/down.html" WithDescription:@"" WithIsImageUrl:NO];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    WLLog(@"UserAgent = %@", [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]);
//    
//    NSString *js = [NSString stringWithFormat:@"setOpenId('%@')",SINGLE.user_info.userInfo.userId];
//    [web stringByEvaluatingJavaScriptFromString:js];
    
}

@end
