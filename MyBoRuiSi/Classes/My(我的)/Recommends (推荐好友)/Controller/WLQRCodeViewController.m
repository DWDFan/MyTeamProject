//
//  WLQRCodeViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2016/11/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLQRCodeViewController.h"
#import "DWDQRImageView.h"

@interface WLQRCodeViewController ()

@end

@implementation WLQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"面对面扫描"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    DWDQRImageView *codeImgV = [[DWDQRImageView alloc] initWithQRImageForString:@"http://www.esd-resource.com/"];
    codeImgV.width = 200;
    codeImgV.height = 200;
    codeImgV.centerX = self.view.centerX;
    codeImgV.centerY = self.view.centerY - 50;
    [self.view addSubview:codeImgV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
