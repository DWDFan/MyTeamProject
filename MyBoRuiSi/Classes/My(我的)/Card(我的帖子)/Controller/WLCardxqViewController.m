//
//  WLCardxqViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCardxqViewController.h"
#import "WLcardTableViewCell.h"

#import "WLcardxqTableViewCell.h"

@interface WLCardxqViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WLCardxqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"帖子详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    //设置导航栏右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"图层-49"] style:UIBarButtonItemStyleDone target:self action:@selector(addxq)];
    
    
//    //头部
//    
//    WLcardTableViewCell *header = [[[NSBundle mainBundle]loadNibNamed:@"WLcardTableViewCell" owner:nil options:nil]lastObject];
//       
//    self.tableView.tableHeaderView = header;
//    

    

    
    
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
//导航栏右边的按钮
-(void)addxq{
    
    
    
}

//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 2;
}
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    int i = 1;
    if (section == 1) {
        i = 7;
    }
    
    
    return i;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int i = 100;
    if (indexPath.section == 0) {
        
        i = 310;
    }
    
    
    return i;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    int i = 0;
    
    if (section == 1) {
        i = 40;
    }
    
    return i ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cells;
    
        
    if (indexPath.section == 0) {
        
        static NSString *ID = @"WLcardTableViewCell";//0
        WLcardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] lastObject];
        }
        
        cells = cell;

    }else if (indexPath.section == 1){
        
        
        static NSString *deteID = @"WLcardxqTableViewCell";//1
        WLcardxqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
        }
        
        cells = cell;
        

        
    }
    
    return cells;
}



//返回组头view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    
    
    if (section == 1) {
        
        
         label.text = @"全部评论";
    }
    
 
    
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    
    
    
    return view;
}


#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
