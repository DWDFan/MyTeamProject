//
//  WLorganVC.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//  机构详情

#import "WLorganVC.h"
#import "WLDetailsHeardTableViewCell.h"
#import "WLDetailsTableViewCell.h"
#import "WLorgTableViewCell.h"
#import "WLInstitutionInfoCell.h"

#import "WLTabulationViewController.h"
#import "WLdetailsViewController.h"
#import "WLCourseDetailViewController.h"

#import "WLdetailstwoViewController.h"//课程详情
#import "WLJrViewController.h"
#import "WLHomeDataHandle.h"
#import "WLInstitutionModel.h"
#import "WLHomeDataHandle.h"

@interface WLorganVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic, strong) WLInstitutionModel *institution;

@end

@implementation WLorganVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"机构详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;

    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];

    //导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"加入机构" style:UIBarButtonItemStyleDone target:self action:@selector(Trestorg)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:164 /255.0 green:30/255.0 blue:59/255.0 alpha:1];
    
    [self requestData];
}

- (void)requestData
{
    [WLHomeDataHandle requestInstitutionDetailWithUid:@"15" jid:_institutionId success:^(id responseObject) {
        
        _institution = [WLInstitutionModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.tableView_main reloadData];
        WLLog(@"*******%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark加入机构
-(void)Trestorg{
    
    WLJrViewController *joinVC = [[WLJrViewController alloc]init];
    joinVC.institutionId = _institutionId;
    joinVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    [self presentViewController:joinVC animated:YES completion:^{
        
    }];
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
//返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
//返回组有多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger i = 1;
    
    if (section == 2) {
        i = _institution.list.count;
    }
    return i;
}
//返回组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.000001 : 44;
}
//反回每个对应cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    static NSString *deteID = @"WLDetailsTableViewCell";
    static NSString *orgID = @"WLorgTableViewCell";
    static NSString *infoID = @"WLInstitutionInfoCell";
    
    if (indexPath.section == 0) {
        
        WLInstitutionInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:infoID];
        if (!infoCell) {
            infoCell = [[[NSBundle mainBundle] loadNibNamed:infoID owner:nil options:nil] lastObject];
        }
        infoCell.institution = _institution;
        [infoCell setBlock:^(UIButton *button) {
            
            NSNumber *type = button.selected ? @0 : @1;
            [WLHomeDataHandle requestHomeFollowInstitutionWithUid:[WLUserInfo share].userId jid:_institutionId type:type Success:^(id responseObject) {
                
                button.selected = !button.selected;
            } failure:^(NSError *error) {
                
            }];
        }];
        cell = infoCell;
        
    }else if (indexPath.section == 1) {
        
        WLorgTableViewCell *cello = [tableView dequeueReusableCellWithIdentifier:orgID];
        
        if (cello == nil) {
            cello = [[[NSBundle mainBundle] loadNibNamed:orgID owner:nil options:nil] lastObject];
        }
        cello.institution = _institution;
        cell = cello;

    }else {
        
        WLDetailsTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:deteID];
        
        if (cells == nil) {
            cells = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
        }
        cells.course = _institution.list[indexPath.row];
        cell = cells;
    }
    return cell;
}
//返回cell高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    int i = 100;
    if (indexPath.section == 0) {
        i = 180;
    }else if(indexPath.section == 1) {
        i = 93;
    }
    return i;
}


//返回组头view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    
    if (section == 1) {
        label.text = @"优秀讲师";
    }else if (section == 2){
        label.text = @"机构课程";
    }
    
    
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    CGFloat btnX = WLScreenW - 20;
    CGFloat btnY = 17;
  
    if (section == 1) {
        
         UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, 10, 10)];
            
        [btn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-138-拷贝-4"] forState:UIControlStateNormal];
            
        [view addSubview:btn];
            
        UIButton *btnt = [[UIButton alloc]initWithFrame:CGRectMake(btn.frame.origin.x-60,0, 60, 44)];
        [btnt setTitle:@"讲师列表" forState:UIControlStateNormal];
        btnt.titleLabel.font = [UIFont systemFontOfSize:14];
        [ btnt setTitleColor:RGBA(139, 34, 56, 1) forState:UIControlStateNormal];
        [view addSubview:btnt];
        //监听按钮方法
        [btnt addTarget:self action:@selector(someButtonClicked)forControlEvents:UIControlEventTouchUpInside];
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma mark//讲师列表
-(void)someButtonClicked{
   // NSLog(@"12");
    //讲师列表
    WLTabulationViewController *tabulat = [[WLTabulationViewController alloc]init];
    tabulat.institutionId = _institutionId;
    [self.navigationController pushViewController:tabulat animated:YES];
    
    
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView_main deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        //课程详情
        WLCourseDetailViewController *vc = [[WLCourseDetailViewController alloc]init];
        vc.courseId = [_institution.list[indexPath.row] id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
