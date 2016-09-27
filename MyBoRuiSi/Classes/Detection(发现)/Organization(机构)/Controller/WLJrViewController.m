//
//  WLJrViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLJrViewController.h"

#import "WLTjViewController.h"

@interface WLJrViewController ()

@end

@implementation WLJrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//取消按钮
- (IBAction)QxbtnaClik:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
//提交按钮
- (IBAction)QdbtnClike:(id)sender {
    
    WLTjViewController *share = [[WLTjViewController alloc]init];
    
//    
//    [share dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    
    [self presentViewController:share animated:YES completion:^{
       // NSLog(@"展示完毕");
    }];
    
    
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//       // NSLog(@"222");
//        
//    }];
    
    
//      WLTjViewController *share = [[WLTjViewController alloc]init];
//    [self.navigationController pushViewController:share animated:YES];
//
    
}

//点击屏幕退出
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
