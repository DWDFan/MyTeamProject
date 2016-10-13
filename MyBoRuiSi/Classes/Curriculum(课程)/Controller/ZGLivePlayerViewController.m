//
//  ZGLivePlayerViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ZGLivePlayerViewController.h"
#import "NELivePlayerController.h"
#import "NELivePlayer.h"


@interface ZGLivePlayerViewController ()

@property(nonatomic, strong) id<NELivePlayer> liveplayer;

@end

@implementation ZGLivePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.liveplayer = [[NELivePlayerController alloc]
                       initWithContentURL:self.url];
    if (self.liveplayer == nil) {
        NSLog(@"failed to initialize!");
    }
    [self.view addSubview:self.liveplayer.view];
    
    //设置播放缓冲策略，直播采用低延时模式，点播采用抗抖动模式，具体可参见API文档
    [self.liveplayer setBufferStrategy:NELPLowDelay];
    //设置画面显示模式，默认按原始大小进行播放，具体可参见API文档
    [self.liveplayer setScalingMode:NELPMovieScalingModeNone];
    //设置视频文件初始化完成后是否自动播放，默认自动播放
    [self.liveplayer setShouldAutoplay:YES];
    //设置是否开启硬件解码，IOS 8.0以上支持硬件解码，默认为软件解码
    [self.liveplayer setHardwareDecoder:NO];
    //设置播放器切入后台后时暂停还是继续播放，默认暂停
    [self.liveplayer setPauseInBackground:NO];
    [self.liveplayer prepareToPlay];
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
