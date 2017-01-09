//
//  WLFinallyViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLFinallyViewController.h"
#import "WLSharetowViewController.h"

#import "WLCepViewController.h"
#import "WLHome.h"

#import "UIImage+Image.h"
#import "WLHomeDataHandle.h"

@interface WLFinallyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;
@property (weak, nonatomic) IBOutlet UIButton *adviceBtn;

@end

@implementation WLFinallyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"测评结果" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    //    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"图层-49"] style:UIBarButtonItemStyleDone target:self action:@selector(nadprerClik)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
    
    [WLHomeDataHandle requestPaperEndTestWithUid:[WLUserInfo share].userId tid:_testId success:^(id responseObject) {
        
        NSString *score = responseObject[@"data"][@"score"];
        NSString *advice = responseObject[@"data"][@"other"];
        self.scoreLbl.text = [NSString stringWithFormat:@"您的成绩为%@分",score];
        [self.adviceBtn setTitle:advice forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)awakeFromNib{
    UIImage *ima = [[UIImage alloc]init];
    ima = UIGraphicsGetImageFromCurrentImageContext();
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

//点击分享
-(void)nadprerClik{
    
    WLSharetowViewController *share = [[WLSharetowViewController alloc]init];
    
    share.shareTitle = self.title;
    share.descStr = self.scoreLbl.text;
//    share.imageUrl = _course.photo;
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    
    [self presentViewController:share animated:YES completion:^{
        // NSLog(@"展示完毕");
    }];
    
    
}
//重新测评
- (IBAction)AgainClik:(id)sender {
    
//    WLCepViewController *cep = [[WLCepViewController alloc]init];
//    [self.navigationController pushViewController:cep animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
}
//返回首页
- (IBAction)HomeClik:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
