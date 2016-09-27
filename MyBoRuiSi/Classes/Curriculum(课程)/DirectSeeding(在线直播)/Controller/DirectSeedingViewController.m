//
//  DirectSeedingViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "DirectSeedingViewController.h"
#import "DirectSeedingTableViewCells.h"
#import "DirectViewController.h"

@interface DirectSeedingViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIButton *InstructionButton;

@property (nonatomic,strong)NSMutableArray *array_main;

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (weak, nonatomic) IBOutlet UIButton *NewestButon;
@property (weak, nonatomic) IBOutlet UIButton *ScreeningButton;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIView *threeView;

@end

@implementation DirectSeedingViewController

- (NSMutableArray *)array_main{
    if (!_array_main) {
        _array_main = [NSMutableArray array];
    }
    return _array_main;
}

//最新 按钮
- (IBAction)NewestButon:(id)sender {
    
   self.NewestButon.selected = !self.NewestButon.selected;
//    
//
    
    self.oneView.hidden = NO;
    self.twoView.hidden = YES;
    self.threeView.hidden = YES;
    
    
    [self.array_main removeAllObjects];
    self.array_main = [NSMutableArray arrayWithObjects:@"11",@"ee",@"df",@"fjdk", nil];
    [self.tableView_main reloadData];
    
}

/**
 *  筛选按钮
 */
- (IBAction)ScreeningButton:(UIButton *)sender {

    self.oneView.hidden = YES;
    self.twoView.hidden = YES;
    self.threeView.hidden = NO;
    
    self.ScreeningButton.selected = !self.ScreeningButton.selected;
    
     [self.array_main removeAllObjects];
    self.array_main = [NSMutableArray arrayWithObjects:@"22",@"ee",@"df",@"fjdk",@"9999", nil];
    [self.tableView_main reloadData];
    
}

/**
 *  价格
 */
- (IBAction)PriceButton:(id)sender {
    
    self.oneView.hidden = YES;
    self.twoView.hidden = NO;
    self.threeView.hidden = YES;
    
    [self.array_main removeAllObjects];
    self.array_main = [NSMutableArray arrayWithObjects:@"11",@"ee", nil];
    
    self.InstructionButton.selected = !self.InstructionButton.selected;
    
    if(self.InstructionButton.selected) {
        
        [self.InstructionButton setBackgroundImage:[UIImage imageNamed:@"MO_2"] forState:UIControlStateNormal];
        
    }else{
        
        
        [self.InstructionButton setBackgroundImage:[UIImage imageNamed:@"MO_1"] forState:UIControlStateNormal];
    }
    
    [self.tableView_main reloadData];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.NewestButon.showsTouchWhenHighlighted = NO;
    
    [self NewestButon:self];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"在线点播" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.array_main.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID_main = @"DirectSeedingTableViewCells";
    DirectSeedingTableViewCells *cells = [tableView dequeueReusableCellWithIdentifier:ID_main];
    if (!cells) {
        
        cells = [[[NSBundle mainBundle] loadNibNamed:ID_main owner:nil options:nil] lastObject];

    }
    
    
    return cells;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DirectViewController *direct = [[DirectViewController alloc] init];
    
    [self.navigationController pushViewController:direct animated:YES];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(139, 34, 56, 1)] forBarMetrics:UIBarMetricsDefault];
    
}


@end
