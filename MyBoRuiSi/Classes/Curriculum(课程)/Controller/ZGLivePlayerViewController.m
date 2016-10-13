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

@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIControl *controlOverlay;
@property (nonatomic, strong) UIView *topControlView;
@property (nonatomic, strong) UIView *bottomControlView;
@property (nonatomic, strong) UIButton *playQuitBtn;
@property (nonatomic, strong) UILabel *fileName;

@property (nonatomic, strong) UILabel *currentTime;
@property (nonatomic, strong) UILabel *totalDuration;
@property (nonatomic, strong) UISlider *videoProgress;

@property (nonatomic, strong) UIActivityIndicatorView *bufferingIndicate;
@property (nonatomic, strong) UILabel *bufferingReminder;

@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *audioBtn;
@property (nonatomic, strong) UIButton *muteBtn;
@property (nonatomic, strong) UIButton *scaleModeBtn;
@property (nonatomic, strong) UIButton *snapshotBtn;

@end

@implementation ZGLivePlayerViewController

NSTimeInterval mDuration;
NSTimeInterval mCurrPos;
CGFloat screenWidth;
CGFloat screenHeight;
bool isHardware = YES;
bool ismute     = NO;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
//    self.liveplayer = [[NELivePlayerController alloc]
//                       initWithContentURL:self.url];
//    if (self.liveplayer == nil) {
//        NSLog(@"failed to initialize!");
//    }
//    [self.view addSubview:self.liveplayer.view];
//    
//    //设置播放缓冲策略，直播采用低延时模式，点播采用抗抖动模式，具体可参见API文档
//    [self.liveplayer setBufferStrategy:NELPLowDelay];
//    //设置画面显示模式，默认按原始大小进行播放，具体可参见API文档
//    [self.liveplayer setScalingMode:NELPMovieScalingModeNone];
//    //设置视频文件初始化完成后是否自动播放，默认自动播放
//    [self.liveplayer setShouldAutoplay:YES];
//    //设置是否开启硬件解码，IOS 8.0以上支持硬件解码，默认为软件解码
//    [self.liveplayer setHardwareDecoder:NO];
//    //设置播放器切入后台后时暂停还是继续播放，默认暂停
//    [self.liveplayer setPauseInBackground:NO];
//    [self.liveplayer prepareToPlay];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    //当前屏幕宽高
    screenWidth  = CGRectGetWidth([UIScreen mainScreen].bounds);
    screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    self.playerView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-20)];
    
    self.mediaControl = [[ZGLivePlayerControl alloc] initWithFrame:CGRectMake(0, 0, screenHeight, screenWidth)];
    [self.mediaControl addTarget:self action:@selector(onClickMediaControl:) forControlEvents:UIControlEventTouchDown];
    
    //控制
    self.controlOverlay = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, screenHeight, screenWidth)];
    [self.controlOverlay addTarget:self action:@selector(onClickOverlay:) forControlEvents:UIControlEventTouchDown];
    
    //顶部控制栏
    self.topControlView    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenHeight, 40)];
    self.topControlView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_background_black.png"]];
    self.topControlView.alpha = 0.8;
    //退出按钮
    self.playQuitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playQuitBtn setImage:[UIImage imageNamed:@"btn_player_quit"] forState:UIControlStateNormal];
    self.playQuitBtn.frame = CGRectMake(10, 0, 40, 40);
    [self.playQuitBtn addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.topControlView addSubview:self.playQuitBtn];
    //文件名
    self.fileName = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, screenHeight - 140, 40)];
    self.fileName.text = [self.url lastPathComponent];
    self.fileName.textAlignment = NSTextAlignmentCenter; //文字居中
    //self.fileName.textColor = [UIColor whiteColor];
    self.fileName.textColor = [[UIColor alloc] initWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    //self.fileName.adjustsFontSizeToFitWidth = YES;
    self.fileName.font = [UIFont fontWithName:self.fileName.font.fontName size:13.0];
    [self.topControlView addSubview:self.fileName];
    
    //缓冲提示
    self.bufferingIndicate = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.bufferingIndicate setCenter:CGPointMake(screenHeight/2, screenWidth/2)];
    [self.bufferingIndicate setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.bufferingIndicate.hidden = YES;
    
    self.bufferingReminder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [self.bufferingReminder setCenter:CGPointMake(screenHeight/2, screenWidth/2 - 50)];
    self.bufferingReminder.text = @"缓冲中";
    self.bufferingReminder.textAlignment = NSTextAlignmentCenter; //文字居中
    self.bufferingReminder.textColor = [UIColor whiteColor];
    self.bufferingReminder.hidden = YES;
    
    
    //底部控制栏
    self.bottomControlView = [[UIView alloc] initWithFrame:CGRectMake(0, screenWidth - 50, screenHeight, 50)];
    self.bottomControlView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_background_black.png"]];
    self.bottomControlView.alpha = 0.8;
    
    //播放按钮
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"btn_player_pause"] forState:UIControlStateNormal];
    self.playBtn.frame = CGRectMake(10, 5, 40, 40);
    [self.playBtn addTarget:self action:@selector(onClickPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:self.playBtn];
    
    //暂停按钮
    self.pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pauseBtn setImage:[UIImage imageNamed:@"btn_player_play"] forState:UIControlStateNormal];
    self.pauseBtn.frame = CGRectMake(10, 5, 40, 40);
    [self.pauseBtn addTarget:self action:@selector(onClickPause:) forControlEvents:UIControlEventTouchUpInside];
    self.pauseBtn.hidden = YES;
    [self.bottomControlView addSubview:self.pauseBtn];
    
    
    //当前播放的时间点
    self.currentTime = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 50, 20)];
    self.currentTime.text = @"00:00:00"; //for test
    self.currentTime.textAlignment = NSTextAlignmentCenter;
    //self.currentTime.textColor = [UIColor whiteColor];
    self.currentTime.textColor = [[UIColor alloc] initWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    //self.fileName.adjustsFontSizeToFitWidth = YES;
    self.currentTime.font = [UIFont fontWithName:self.currentTime.font.fontName size:10.0];
    [self.bottomControlView addSubview:self.currentTime];
    
    //播放进度条
    self.videoProgress = [[UISlider alloc] initWithFrame:CGRectMake(100, 10, screenHeight-320, 30)];
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"btn_player_slider_thumb"] forState:UIControlStateNormal];
    [[UISlider appearance] setMaximumTrackImage:[UIImage imageNamed:@"btn_player_slider_all"] forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:[UIImage imageNamed:@"btn_player_slider_played"] forState:UIControlStateNormal];
    //[self.videoProgress setThumbImage:[UIImage imageNamed:@"btn_player_slider_thumb"] forState:UIControlStateNormal];
    
    [self.videoProgress addTarget:self action:@selector(onClickSeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:self.videoProgress];
    
    
    //文件总时长
    self.totalDuration = [[UILabel alloc] initWithFrame:CGRectMake(screenHeight-215, 15, 50, 20)];
    self.totalDuration.text = @"--:--:--";
    self.totalDuration.textAlignment = NSTextAlignmentCenter;
    //self.totalDuration.textColor = [UIColor whiteColor];
    self.totalDuration.textColor = [[UIColor alloc] initWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.totalDuration.font = [UIFont fontWithName:self.totalDuration.font.fontName size:10.0];
    [self.bottomControlView addSubview:self.totalDuration];
    
    
    //声音打开按钮
    self.audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.audioBtn setImage:[UIImage imageNamed:@"btn_player_mute02"] forState:UIControlStateNormal];
    self.audioBtn.frame = CGRectMake(screenHeight-150, 5, 40, 40);
    [self.audioBtn addTarget:self action:@selector(onClickMute:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:self.audioBtn];
    
    //静音按钮
    self.muteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.muteBtn setImage:[UIImage imageNamed:@"btn_player_mute01"] forState:UIControlStateNormal];
    self.muteBtn.frame = CGRectMake(screenHeight-150, 5, 40, 40);
    [self.muteBtn addTarget:self action:@selector(onClickMute:) forControlEvents:UIControlEventTouchUpInside];
    self.muteBtn.hidden = YES;
    [self.bottomControlView addSubview:self.muteBtn];
    
    //截图
    self.snapshotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.snapshotBtn setImage:[UIImage imageNamed:@"btn_player_snap"] forState:UIControlStateNormal];
    self.snapshotBtn.frame = CGRectMake(screenHeight-100, 5, 40, 40);
//    if ([self.mediaType isEqualToString:@"localAudio"]) {
//        self.snapshotBtn.hidden = YES;
//    }
    [self.snapshotBtn addTarget:self action:@selector(onClickSnapshot:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:self.snapshotBtn];
    
    
    //显示模式
    self.scaleModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scaleModeBtn setImage:[UIImage imageNamed:@"btn_player_scale02"] forState:UIControlStateNormal];
    self.scaleModeBtn.frame = CGRectMake(screenHeight-50, 5, 40, 40);
    if ([self.mediaType isEqualToString:@"localAudio"]) {
        self.scaleModeBtn.hidden = YES;
    }
    
    [self.scaleModeBtn addTarget:self action:@selector(onClickScaleMode:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:self.scaleModeBtn];
    
    
    
    if ([self.decodeType isEqualToString:@"hardware"]) {
        isHardware = YES;
    }
    else if ([self.decodeType isEqualToString:@"software"]) {
        isHardware = NO;
    }
    
    [self.controlOverlay addSubview:self.topControlView];
    [self.controlOverlay addSubview:self.bottomControlView];
    
    [NELivePlayerController setLogLevel:NELP_LOG_DEBUG];
    
    
    
    self.liveplayer = [[NELivePlayerController alloc] initWithContentURL:self.url];
    if (self.liveplayer == nil) { // 返回空则表示初始化失败
        NSLog(@"player initilize failed, please tay again!");
    }
    self.liveplayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.liveplayer.view.frame = self.playerView.bounds;
    [self.liveplayer setScalingMode:NELPMovieScalingModeFill];
    
    self.view.autoresizesSubviews = YES;
    
    [self.mediaControl addSubview:self.controlOverlay];
    [self.view addSubview:self.liveplayer.view];
    [self.view addSubview:self.mediaControl];
    [self.view addSubview:self.bufferingIndicate];
    [self.view addSubview:self.bufferingReminder];
    self.mediaControl.delegatePlayer = self.liveplayer;
    
}




@end
