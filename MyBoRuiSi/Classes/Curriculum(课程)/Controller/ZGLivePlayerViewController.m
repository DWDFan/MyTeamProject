//
//  ZGLivePlayerViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ZGLivePlayerViewController.h"
#import "NELivePlayerController.h"
#import "WLReportViewController.h"
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


- (instancetype)initWithURL:(NSURL *)url andDecodeParm:(NSMutableArray *)decodeParm {
    self = [super init];
    if (self) {
        self.url = url;
        self.decodeType = [decodeParm objectAtIndex:0];
        self.mediaType = [decodeParm objectAtIndex:1];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerVideoParseError:)
                                                 name:NELivePlayerVideoParseErrorNotification
                                               object:_liveplayer];
}

- (void)loadView
{
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
    self.bottomControlView = [[UIView alloc] initWithFrame:CGRectMake(0, screenWidth - 50, screenWidth, 50)];
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
    self.videoProgress = [[UISlider alloc] initWithFrame:CGRectMake(100, 10, screenWidth - 200, 30)];
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"btn_player_slider_thumb"] forState:UIControlStateNormal];
    [[UISlider appearance] setMaximumTrackImage:[UIImage imageNamed:@"btn_player_slider_all"] forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:[UIImage imageNamed:@"btn_player_slider_played"] forState:UIControlStateNormal];
    //[self.videoProgress setThumbImage:[UIImage imageNamed:@"btn_player_slider_thumb"] forState:UIControlStateNormal];
    
    [self.videoProgress addTarget:self action:@selector(onClickSeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:self.videoProgress];
    
    
    //文件总时长
    self.totalDuration = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-100, 15, 50, 20)];
    self.totalDuration.text = @"--:--:--";
    self.totalDuration.textAlignment = NSTextAlignmentCenter;
    //self.totalDuration.textColor = [UIColor whiteColor];
    self.totalDuration.textColor = [[UIColor alloc] initWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.totalDuration.font = [UIFont fontWithName:self.totalDuration.font.fontName size:10.0];
    [self.bottomControlView addSubview:self.totalDuration];
    
    
    //显示模式
    self.scaleModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scaleModeBtn setImage:[UIImage imageNamed:@"btn_player_scale02"] forState:UIControlStateNormal];
    self.scaleModeBtn.frame = CGRectMake(screenWidth-50, 5, 40, 40);
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
//    self.liveplayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.liveplayer.view.frame = CGRectMake(0, 0, screenWidth, screenWidth);
//    [self.liveplayer setScalingMode:NELPMovieScalingModeAspectFill];
//    self.liveplayer.view.backgroundColor = [UIColor blueColor];

    self.view.autoresizesSubviews = YES;
    
    [self.mediaControl addSubview:self.controlOverlay];
    [self.view addSubview:self.liveplayer.view];
    [self.view addSubview:self.mediaControl];
    [self.view addSubview:self.bufferingIndicate];
    [self.view addSubview:self.bufferingReminder];
    self.mediaControl.delegatePlayer = self.liveplayer;
    
    UILabel *tipLbl = [[UILabel alloc] init];
    tipLbl.frame = CGRectMake(ZGPaddingMax, 370, WLScreenW, 12);
    tipLbl.textColor = color_red;
    tipLbl.font = [UIFont systemFontOfSize:12];
    tipLbl.text = @"温馨提示：您还未购买，只能试看5分钟哦！";
    [self.view addSubview:tipLbl];
    self.tipLbl = tipLbl;
    self.tipLbl.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSString *title = [self.mediaType isEqualToString:@"livestream"] ? @"观看直播" : @"观看点播";
    [self setNavigationBarStyleDefultWithTitle:title];
    [self settitleColor:[UIColor whiteColor] backgroundColor:[UIColor blackColor]];
    self.leftBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"举报"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
    
    [self.liveplayer isLogToFile:YES];
    
    if ([self.mediaType isEqualToString:@"livestream"]) {
        [self.liveplayer setBufferStrategy:NELPLowDelay];           //直播低延时模式
    }
    else {
        [self.liveplayer setBufferStrategy:NELPAntiJitter];         //点播抗抖动
    }
    [self.liveplayer setScalingMode:NELPMovieScalingModeAspectFit]; //设置画面显示模式，默认原始大小
    [self.liveplayer setShouldAutoplay:YES];                        //设置prepareToPlay完成后是否自动播放
    [self.liveplayer setHardwareDecoder:isHardware];                //设置解码模式，是否开启硬件解码
    [self.liveplayer setPauseInBackground:NO];                      //设置切入后台时的状态，暂停还是继续播放
    [self.liveplayer prepareToPlay];                                //初始化视频文件
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.liveplayer shutdown]; //退出播放并释放相关资源
    [self.liveplayer.view removeFromSuperview];
    self.liveplayer = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerDidPreparedToPlayNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerLoadStateChangedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerPlaybackFinishedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstVideoDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstAudioDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerVideoParseErrorNotification object:_liveplayer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGB(255, 255, 255)] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)rightBtnAction:(id)sender
{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    self.scaleModeBtn.titleLabel.tag = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WLReportViewController *VC = [[WLReportViewController alloc] init];
        VC.articleId = _courseId;
        [self.navigationController pushViewController:VC animated:YES];
    });
    
}


#pragma mark - IBAction

//退出播放
- (void)onClickBack:(id)sender
{
    NSLog(@"click back!");
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

//seek操作
- (void)onClickSeek:(id)sender
{
    NSLog(@"click seek");
    if ([self.mediaType isEqualToString:@"livestream"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"直播流不支持seek操作." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    NSTimeInterval currentPlayTime = self.videoProgress.value;
    [self.liveplayer setCurrentPlaybackTime:currentPlayTime];
    [self syncUIStatus];
}

//开始播放
- (void)onClickPlay:(id)sender
{
    NSLog(@"click pause");
    [self.liveplayer play];
    [self syncUIStatus];
}

//暂停播放
- (void)onClickPause:(id)sender
{
    NSLog(@"click pause");
    [self.liveplayer pause];
    [self syncUIStatus];
}

//静音
- (void)onClickMute:(id)sender
{
    NSLog(@"click mute");
    if (ismute) {
        [self.liveplayer setMute:!ismute];
        self.muteBtn.hidden = YES;
        self.audioBtn.hidden = NO;
        ismute = NO;
    }
    else {
        [self.liveplayer setMute:!ismute];
        self.muteBtn.hidden = NO;
        self.audioBtn.hidden = YES;
        ismute = YES;
    }
}

//显示模式
- (void)onClickScaleMode:(id)sender
{
    NSLog(@"click scale mode %ld", _scaleModeBtn.titleLabel.tag);
    switch (self.scaleModeBtn.titleLabel.tag) {
        case 0:
            [self.scaleModeBtn setImage:[UIImage imageNamed:@"btn_player_scale01"] forState:UIControlStateNormal];
//            [self.liveplayer setScalingMode:NELPMovieScalingModeNone];
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
            self.scaleModeBtn.titleLabel.tag = 1;
            break;
        case 1:
            [self.scaleModeBtn setImage:[UIImage imageNamed:@"btn_player_scale02"] forState:UIControlStateNormal];
//            [self.liveplayer setScalingMode:NELPMovieScalingModeAspectFit];
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
            self.scaleModeBtn.titleLabel.tag = 0;
            break;
        default:
            [self.scaleModeBtn setImage:[UIImage imageNamed:@"btn_player_scale02"] forState:UIControlStateNormal];
//            [self.liveplayer setScalingMode:NELPMovieScalingModeAspectFit];
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
            self.scaleModeBtn.titleLabel.tag = 0;
            break;
    }

}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        
        self.bottomControlView.width = WLScreenW;
        if (orientation == UIInterfaceOrientationPortrait) {
            self.bottomControlView.y = WLScreenW - 50;
            self.liveplayer.view.frame = CGRectMake(0, 0, WLScreenW, WLScreenW);
        }else {
            self.bottomControlView.y = WLScreenH - 80;
            self.liveplayer.view.frame = CGRectMake(0, 0, WLScreenW, WLScreenH - 32);
        }
        self.videoProgress.frame = CGRectMake(100, 10, self.bottomControlView.width - 200, 30);
        self.totalDuration.frame = CGRectMake(self.bottomControlView.width - 100, 15, 50, 20);
        self.scaleModeBtn.frame = CGRectMake(self.bottomControlView.width - 50, 5, 40, 40);

    }
}

//截图
- (void)onClickSnapshot:(id)sender
{
    NSLog(@"click snap");
    
    UIImage *snapImage = [self.liveplayer getSnapshot];
    
    UIImageWriteToSavedPhotosAlbum(snapImage, nil, nil, nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"截图已保存到相册" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

//触摸overlay
- (void)onClickOverlay:(id)sender
{
    NSLog(@"click overlay");
    self.controlOverlay.hidden = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(controlOverlayHide) object:nil];
}

- (void)onClickMediaControl:(id)sender
{
    NSLog(@"click mediacontrol");
    self.controlOverlay.hidden = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(controlOverlayHide) object:nil];
    [self syncUIStatus];
    [self performSelector:@selector(controlOverlayHide) withObject:nil afterDelay:8];
}

- (void)controlOverlayHide
{
    self.controlOverlay.hidden = YES;
}

- (void)syncUIStatus
{
    mDuration = [self.liveplayer duration];
    NSInteger duration = round(mDuration);
    
    mCurrPos  = [self.liveplayer currentPlaybackTime];
    NSInteger currPos  = round(mCurrPos);
    
    self.currentTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)(currPos / 3600), (int)(currPos > 3600 ? (currPos - (currPos / 3600)*3600) / 60 : currPos/60), (int)(currPos % 60)];
    
    if (duration > 0) {
        self.totalDuration.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)(duration / 3600), (int)(duration > 3600 ? (duration - 3600 * (duration / 3600)) / 60 : duration/60), (int)(duration > 3600 ? ((duration - 3600 * (duration / 3600)) % 60) :(duration % 60))];
        //[self.videoProgress setValue:(float)mCurrPos/mDuration]; //seek的时候会回到开始的位置
        self.videoProgress.value = mCurrPos;
        self.videoProgress.maximumValue = mDuration;
    } else {
        [self.videoProgress setValue:0.0f];
    }
    
    if ([self.liveplayer playbackState] == NELPMoviePlaybackStatePlaying) {
        self.playBtn.hidden = YES;
        self.pauseBtn.hidden = NO;
    }
    else {
        self.playBtn.hidden = NO;
        self.pauseBtn.hidden = YES;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(syncUIStatus) object:nil];
    if (!self.playQuitBtn.hidden) {
        [self performSelector:@selector(syncUIStatus) withObject:nil afterDelay:0.5];
    }
}


- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification
{
    //add some methods
    NSLog(@"NELivePlayerDidPreparedToPlay");
    [self syncUIStatus];
    [self.liveplayer play]; //开始播放
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification
{
    NELPMovieLoadState nelpLoadState = _liveplayer.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");
        self.bufferingIndicate.hidden = YES;
        self.bufferingReminder.hidden = YES;
        [self.bufferingIndicate stopAnimating];
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
        self.bufferingIndicate.hidden = NO;
        self.bufferingReminder.hidden = NO;
        [self.bufferingIndicate startAnimating];
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification
{
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
            if ([self.mediaType isEqualToString:@"livestream"]) {
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
                action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    if (self.presentingViewController) {
                        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                    }}];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            break;
            
        case NELPMovieFinishReasonPlaybackError:
            alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"播放失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
            
        case NELPMovieFinishReasonUserExited:
            break;
            
        default:
            break;
    }
}

- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification
{
    NSLog(@"first video frame rendered!");
}

- (void)NELivePlayerFirstAudioDisplayed:(NSNotification*)notification
{
    NSLog(@"first audio frame rendered!");
}

- (void)NELivePlayerVideoParseError:(NSNotification*)notification
{
    NSLog(@"video parse error!");
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification
{
    NSLog(@"resource release success!!!");
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerReleaseSueecssNotification object:_liveplayer];
}

- (void)leftBtnAction:(UIButton *)sender
{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
