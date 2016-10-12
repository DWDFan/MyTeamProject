

NSInteger const kPageSize = 20;
#import "BaseViewController.h"
//#import "PersonalRequestClient.h"
@interface BaseViewController()<UIGestureRecognizerDelegate>
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.leftBtn.userInteractionEnabled = NO;
    WLLog(@"current UIViewController is:%@",NSStringFromClass(self.class));
//    if (!SINGLE.isLogin) {
//        [[Common shareAppDelegate] pushLogin];
//    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.leftBtn.userInteractionEnabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if ([self.navigationController.viewControllers count] > 1 || self.presentingViewController != nil){
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
//        self.leftBtn.hidden = NO;
    }
    
    self.pageNo = 1;
}

- (void)setNavigationBarStyleDefultWithTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
}

-(NSMutableArray *)dataSoureArray{
    if(!_dataSoureArray){
        _dataSoureArray = [NSMutableArray new];
    }
    return _dataSoureArray;
}

//- (UIButton *)leftBtn{
//    if(!_leftBtn){
//        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _leftBtn.frame = CGRectMake(0, 0,25, 25);
//        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        _leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(5, -5, 0, 0);
//        [_leftBtn setImage:[UIImage imageNamed:@"goback"] forState:0];
//        [_leftBtn addTarget:self
//                    action:@selector(leftBtnAction:)
//          forControlEvents:UIControlEventTouchUpInside];
//        [_leftBtn setTitleColor:[UIColor blackColor] forState:0];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
//    }
//    
//    return _leftBtn;
//}

-(UIBarButtonItem *)rightBtnItem{
    if(!_rightBtnItem){
        _rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction:)];
        [_rightBtnItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIFont systemFontOfSize:16], NSFontAttributeName,
                                             [UIColor blackColor], NSForegroundColorAttributeName,
                                               nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem =_rightBtnItem;
    }
    return _rightBtnItem;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame=CGRectMake(0, 0, 40, 25);
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        _rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_rightBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
        self.navigationItem.rightBarButtonItem=item;
    }
    return _rightBtn;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WLScreenW, WLScreenH-IOS7_TOP_Y) style:self.tableViewStyle?self.tableViewStyle:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate  = self;
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorColor = COLOR_tableView_separator;
        [self.view addSubview:_tableView];
        _tableView.separatorColor = [UIColor colorWithWhite:0.2 alpha:0.1];
    }
    return _tableView;
}

- (void)hideShadow{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}


-(void)iNeedALine{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    CGRect rect = CGRectMake(0, 0, self.view.width, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,RGB(201, 201, 202).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.navigationController.navigationBar.shadowImage= img;
}

#pragma mark --- 导航栏左侧按钮点击方法 ---
- (void)leftBtnAction:(UIButton *)sender{
    //子类可以重写该方法
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 导航栏右侧按钮点击方法 ---

- (void)rightBtnAction:(id )sender{
    //由子类实现具体的方法
}

#pragma mark --- 隐藏和显示标签栏 ---

- (void)hiddenTabBar{
    [self.view addSubview:self.barTabImageView];
}

- (void)showTabBar{
    [self.tabBarController.view addSubview:self.barTabImageView];
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 0;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{   
//    return nil;
//}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//    
//}

-(NSString*)nsintChangeNSstring:(NSInteger)i{
    NSString * ii = [NSString stringWithFormat:@"%ld",(long)i];
    return ii;
}

-(void)isJudgeLogin{
//    [[PersonalRequestClient sharedClient] getUserAssetsListprogress:^(NSProgress *uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject, JCRespone * _Nonnull respone) {
//        SINGLE.isLogin = YES;
//        [UserDefaults setData:respone.data[@"userAccount"] key:@"userAccount"];
////        self.block(YES);
//        [UserDefaults setData:@(YES) key:@"isLogin"];
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, JCRespone * _Nonnull respone) {
//        NSLog(@"%@",respone.code);
//        if ([respone.code isEqualToString:@"0000000"]) {
//            SINGLE.isLogin = NO;
//            [UserDefaults setData:@(NO) key:@"isLogin"];
////            self.block(NO);
//        }
//    }];
}




#pragma mark 基本设置
- (void)baseSettting
{
#ifdef __IPHONE_7_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
}

@end
