//
//  DirectViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "DirectViewController.h"
#import "DirectTableViewCellTwo.h"
#import "DirectTableViewCell.h"
#import "DirectTableViewCellThree.h"
#import "AppraisalViewController.h"

@interface DirectViewController ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation DirectViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"课情详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(qixbtn)];
    

    
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

-(void)qixbtn{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int row = 0;
    
    if (section == 0) {
        row = 4;
    }else if (section == 1) {
        row = 1;
    }else if (section == 2) {
        
        
    }else{
        
        row = 3;
        
    }
    
    
    return row;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    id view_main;
    
    UIView *view = [UIView new];
    view.backgroundColor = RGBA(237, 237, 237, 1);
    UILabel *lable_main = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 20)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WLScreenW - 20, 12, 10, 12)];
    [view addSubview:lable_main];
    [view addSubview:imageView];
    
    if (section == 0) {
        
            return nil;
        
    }else if (section == 1) {
        lable_main.text = @"课程介绍";
        view_main = view;
        
    }else if (section == 2) {
        
        lable_main.text = @"教学大纲";
        imageView.image = [UIImage imageNamed:@"素彩网www.sc115.com-138-拷贝-2"];
         view_main = view;
        
    }else{
        
        lable_main.text = @"评价 (88)";
         view_main = view;
    }
    
    return view_main;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 45.0;
    
    if (indexPath.section == 1) {
        
        height = 150.0;
        
    }else if (indexPath.section == 2){
        height = 1;
    }else if (indexPath.section == 3){
        
        height = 80.0;
        
    }
    
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.1;
    }
    
    
    return 45.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cell;
    
    static NSString *ID_One = @"DirectTableViewCell";
    static NSString *ID_Two = @"DirectTableViewCellTwo";
    static NSString *ID_Three = @"DirectTableViewCellThree";
    
    DirectTableViewCell *direct = [tableView dequeueReusableCellWithIdentifier:ID_One];
    if (!direct) {
        
        direct = [[[NSBundle mainBundle] loadNibNamed:ID_One owner:nil options:nil] lastObject];
    }

    DirectTableViewCellTwo *directTwo = [tableView dequeueReusableCellWithIdentifier:ID_Two];
    if (!directTwo) {
        
        directTwo = [[[NSBundle mainBundle] loadNibNamed:ID_Two owner:nil options:nil] lastObject];
    }

    DirectTableViewCellThree *directThree = [tableView dequeueReusableCellWithIdentifier:ID_Three];
    if (!directThree) {
        
        directThree = [[[NSBundle mainBundle] loadNibNamed:ID_Three owner:nil options:nil] lastObject];
    }


    
    
    UITableViewCell *cellFive = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            direct.label_main.text = @"ESD基础知识盘点";
        }else if (indexPath.row == 1) {
            
            direct.label_main.text = @"¥ 8888";
            direct.label_main.textColor = [UIColor redColor];
        }else if (indexPath.row == 2) {
            
            direct.label_main.text = @"发布: 默默培训机构";
            direct.iconName.image = [UIImage imageNamed:@"素彩网www.sc115.com-138-拷贝-2"];
        }else{
            
            direct.label_main.text = @"截止时间: 2018-8-8";
            
        }
        
        
        cell = direct;
        

    }else if (indexPath.section == 1) {
        
        directTwo.textView_main.text = @"好烦撒娇的附件是领导回复;啥都离开房间雷克萨大家来付款就爱死了肯定就发了;空间撒的垃圾卡疯了;就开始大量积分了;啥都解放路口就撒旦了;附近拉萨的会计法律; 就啥都离开房间老是卡;减肥了空间撒大路口附近沙发和撒谎地方加号加上地方还是大家回复卡还是叫开发和圣诞节可减肥哈市的回复啦;是导航";
        cell = directTwo;
        
        
    }else if(indexPath.section == 2) {
        
        cell = cellFive;
        
        
    }else{
        
        if (indexPath.row == 2) {
            
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WLScreenW / 2, 15, 70, 40)];
            [button setTitle:@"查看全部" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [button setBackgroundColor:RGBA(237, 237, 237, 1)];
            
            [cellFive addSubview:button];
            [button addTarget:self action:@selector(button_main:) forControlEvents:UIControlEventTouchDown];
            
            cell = cellFive;
            
            
        }else{
            
            
             cell = directThree;
        }
        
        
        
    }
    
    
    
    
    
    
    return cell;
    
}

- (void)button_main:(UIButton *)button{
    
    AppraisalViewController *apprais = [[AppraisalViewController alloc] init];
    
    [self.navigationController pushViewController:apprais animated:YES];
    
    
}



@end
