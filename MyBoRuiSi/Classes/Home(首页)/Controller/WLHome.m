//
//  WLHome.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLHome.h"
#import "SDCycleScrollView.h"
#import "SDCollectionViewCell.h"

#import "CurriculumModel.h"
#import "RecommendModell.h"
#import "RecommendationModelll.h"

#import "WLHomeTableViewCell.h"
#import "WLhomeOneTableViewCell.h"
#import "WLHometwoTableViewCell.h"
#import "WLHomethreeTableViewCell.h"

#import "WLInquiryViewController.h"
#import "WLSearchTableViewController.h"

#import "WLEvaluationViewController.h"
#import "WLTeacherViewController.h"
#import "WLorganizationgViewController.h"

#import "WLdetailstwoViewController.h"
#import "WLDetailsViewController.h"
#import "WLorganVC.h"

#import "UIImage+Image.h"
#import "AFNetworking.h"
#import "WLCourseDetailViewController.h"
#import "WLLiveCourseDetailViewController.h"
#import "WLArticleDetailViewController.h"
#import "WebViewController.h"
#import "WLRegisteringViewController.h"


@interface WLHome ()<SDCycleScrollViewDelegate,UISearchBarDelegate,UIAlertViewDelegate>

@property(nonatomic,strong) UIView *views;

@property (nonatomic,strong) NSMutableArray *arr_curriculum;

@property (nonatomic,strong)NSMutableArray *teacherArray;

@property (nonatomic,strong)NSMutableArray *arr_Recommendation;

@property (nonatomic, strong) NSArray *adsArray;

@end


@implementation WLHome

- (NSMutableArray *)arr_curriculum
{
    if (!_arr_curriculum) {
        _arr_curriculum = [NSMutableArray array];
    }
    return _arr_curriculum;
}


- (NSMutableArray *)teacherArray
{
    if (!_teacherArray) {
        _teacherArray = [NSMutableArray array];
    }
    return _teacherArray;
}

- (NSMutableArray *)arr_Recommendation
{
    if (!_arr_Recommendation) {
        _arr_Recommendation = [NSMutableArray array];
    }
    return _arr_Recommendation;
}

-(UIView *)views{
    if (_views == nil) {
        _views = [[UIView alloc]init];
    }
    return _views;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self postUpLoad];
    
    //图片轮播器
    SDCycleScrollView *scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Swidth, 210) delegate:self placeholderImage:[UIImage imageNamed:@"图层-50_88"]];
    
    self.tableView.tableHeaderView = scrollview;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 60)];
    search.placeholder = @"搜索";
    search.delegate = self;
    self.navigationItem.titleView = search;
   
    [MOHTTP Post:@"API/index.php?action=Ad&do=homeAd" parameters:@{} success:^(id responseObject) {
        
        NSDictionary *dic = responseObject;
        //返回参数
        if ([dic[@"code"] intValue] == 1 ) {
            
            self.adsArray = dic[@"data"];
            NSMutableArray *mutabArray = [NSMutableArray array];
            for (NSDictionary *dic  in self.adsArray) {
                [mutabArray addObject:dic[@"img"]];
            }
            scrollview.imageURLStringsGroup = mutabArray;
        }else{
            
            [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
  
    //精选课程数据
    [self getData];

    //推荐讲师数据
    [self getAlecturer];
    
    //推荐机构数据
    [self getRecommendation];
}

- (void)getData
{
    NSDictionary *params = @{ @"num" : @"10"};
    
    [MOHTTP Post:@"API/index.php?action=Ad&do=GoodKc" parameters:params success:^(id responseObject) {
        NSLog(@"%@+++++++",responseObject);
        NSDictionary *dic = responseObject;
        //返回参数
        if ([dic[@"code"] intValue] == 1 ) {
            
            //用数组取值
            NSArray *array_main = dic[@"data"];
            
            self.arr_curriculum = [CurriculumModel mj_objectArrayWithKeyValuesArray:array_main];
            [self.tableView reloadData];
            
        }else{
            
            [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
            
        }

//        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

- (void)getAlecturer{
    NSDictionary *param = @{@"num" : @"10"};
    
    [MOHTTP Post:@"API/index.php?action=Ad&do=GoodJs" parameters:param success:^(id responseObject) {
        NSLog(@"%@+++++++",responseObject);
        NSDictionary *dic = responseObject;
        //返回参数
        if ([dic[@"code"] intValue] == 1 ) {
            
            //用数组取值
            NSArray *array_mains = dic[@"data"];
            
            self.teacherArray = [RecommendModell mj_objectArrayWithKeyValuesArray:array_mains];
            
            [self.tableView reloadData];
            
        }else{
            
            [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
            
        }
//                NSLog(@"%@",responseObject);

    } failure:^(NSError *error) {
        
    }];

}

- (void)getRecommendation
{
    NSDictionary *params = @{@"num" : @"10"};
    
    [MOHTTP Post:@"API/index.php?action=Ad&do=GoodJg" parameters:params success:^(id responseObject) {
        NSLog(@"%@+++++++",responseObject);
        NSDictionary *dic = responseObject;
        //返回参数
        if ([dic[@"code"] intValue] == 1 ) {
            
            //用数组取值
            NSArray *array_maina = dic[@"data"];
            
            self.arr_Recommendation = [RecommendationModelll mj_objectArrayWithKeyValuesArray:array_maina];
            
            [self.tableView reloadData];
            
        }else{
            
            [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
        }

        NSLog(@"%@",self.arr_Recommendation);

    } failure:^(NSError *error) {
        
    }];
}

// 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSDictionary *dict = self.adsArray[index];
    NSString *type = dict[@"type"];
    
    if ([type isEqualToString:@"kecheng"]) {
        
        WLCourseDetailViewController *VC = [[WLCourseDetailViewController alloc] init];
        VC.courseId = dict[@"url"];
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([type isEqualToString:@"bbs"]) {
    
        WLArticleDetailViewController *VC = [[WLArticleDetailViewController alloc] init];
        VC.articleId = dict[@"url"];
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([type isEqualToString:@"other"]){
    
        WebViewController *VC = [[WebViewController alloc] init];
        VC.urlstr = dict[@"url"];
        VC.titleStr = dict[@"title"];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//cancel按钮点击时调用
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar

{    WLSearchTableViewController *search = [[WLSearchTableViewController alloc]init];
    //    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];

    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger i = 1;
    
    if (section == 1) {
        i = self.arr_curriculum.count;
    }else if (section == 2){
        i = self.teacherArray.count;
    }else if (section == 3){
        i = self.arr_Recommendation.count;
    }

    return i;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    int i = 44;
    
    if (section == 0) {
        i = 0.01;
    }
    return i ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

//点击cell所
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        //课程详情
        CurriculumModel *model = _arr_curriculum[indexPath.row];
        
        if ([model.type isEqualToNumber:@1]) {
            WLCourseDetailViewController *detail = [[WLCourseDetailViewController alloc] init];
            detail.courseId = [_arr_curriculum[indexPath.row] id];
            [self.navigationController pushViewController:detail animated:YES];
        }else {
            WLLiveCourseDetailViewController *vc = [[WLLiveCourseDetailViewController alloc] init];
            vc.courseId =  [_arr_curriculum[indexPath.row] id];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section == 2){
        //讲师详情
        WLDetailsViewController *details = [[WLDetailsViewController alloc]init];
        details.teacherId = [_teacherArray[indexPath.row] id];
        [self.navigationController pushViewController:details animated:YES];
    }else if (indexPath.section == 3){
        
        //机构详情
        WLorganVC *vc = [[WLorganVC alloc]init];
        vc.institutionId = [_arr_Recommendation[indexPath.row] id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    id cell;

        __weak typeof(self) weakSelf = self;

    
    if (indexPath.section == 0) {
        
        static NSString *deteID = @"WLHomeTableViewCell";
        WLHomeTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:deteID];
        
        if (cells == nil) {
            cells = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
            cells.selectionStyle = UITableViewCellSelectionStyleNone;
        }
                //证书查询
                cells.WLHomeTableViewCellBlock = ^(){
                    
                    //证书查询
                    if (![WLUserInfo share].isLogin) {
                        
                        [self alertLogin];
                        return ;
                    }
                    WLInquiryViewController *inqui = [[WLInquiryViewController alloc]init];
                    [weakSelf.navigationController pushViewController:inqui animated:YES];
               };

                cells.WLHomeTableViewCellBlockTwo = ^(){
                    
                    if (![WLUserInfo share].isLogin) {
                        
                        [self alertLogin];
                        return ;
                    }
                    //在线测评
                    WLEvaluationViewController *evaluation = [[WLEvaluationViewController alloc]init];
                    [weakSelf.navigationController pushViewController:evaluation animated:YES];
                };
                
                cells.WLHomeTableViewCellBlockThree = ^(){
                    
                    //推荐讲师
                    WLTeacherViewController *teacher = [[WLTeacherViewController alloc]init];
                    [weakSelf.navigationController pushViewController:teacher animated:YES];
                };

                cells.WLHomeTableViewCellBlockFour = ^(){
                    
                    //推荐机构
                    WLorganizationgViewController *org = [[WLorganizationgViewController alloc]init];
                    [weakSelf.navigationController pushViewController:org animated:YES];
                };
        
        cell = cells;

    }else if (indexPath.section == 1){
        
        static NSString *deteID = @"WLhomeOneTableViewCell";
        WLhomeOneTableViewCell *cello = [tableView dequeueReusableCellWithIdentifier:deteID];
        
        if (cello == nil) {
            cello = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
        }
        CurriculumModel *model = self.arr_curriculum[indexPath.row];
        cello.model = model;
        cell = cello;
        
    }else if (indexPath.section == 2){
        static NSString *deteID = @"WLHometwoTableViewCell";
        WLHometwoTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:deteID];
        
        if (cells == nil) {
            cells = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
        }
        
        RecommendModell *modell = self.teacherArray[indexPath.row];
        cells.Modell = modell;
        
        cell = cells;

    }else{
        
        static NSString *deteID = @"WLHomethreeTableViewCell";
        WLHomethreeTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:deteID];
        
        if (cells == nil) {
            cells = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
        }
        RecommendationModelll *modelll = self.arr_Recommendation[indexPath.row];
        cells.Modelll = modelll;
        
        cell = cells;
        
    }
    
    
    return cell;
}

- (void)alertLogin
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您需要登陆后才能进行操作！" delegate:self cancelButtonTitle:@"暂不登录" otherButtonTitles:@"去登陆", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [MOTool pushLoginViewControllerWithController:self];
    }
}

//开始触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
//    [self postUpLoad];
}

//已登录
-(void)CanbtnClik:(UIButton *)btn{
  
    
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    int i = 100;
    if (indexPath.section == 2) {
        i = 262;
    }else if (indexPath.section == 3){
        i = 262;
    }
    
    return i;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = @"";
    
    
    if (section == 1) {
        str = @"精选课程";
    }else if (section == 2){
        str = @"推荐名师";
    }else if (section == 3){
        str = @"推荐机构";
    }
    
    return str;
}

//返回组头view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    
    if (section == 1) {
         label.text = @"精选课程";
    }else if (section == 2){
           label.text = @"推荐名师";
    }else if (section == 3){
           label.text = @"推荐机构";
    }
    
   
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    
    
    
    return view;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(139.0, 23.0, 55.0, 1)] forBarMetrics:UIBarMetricsDefault];
    
}


@end
