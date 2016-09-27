//
//  WLSouTableViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSouTableViewController.h"
#import "WLSouTableViewCell.h"

@interface WLSouTableViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton *button_main;
@property (nonatomic,strong)UITextField *textFiled_main;

@end

@implementation WLSouTableViewController


- (UIButton *)button_main{
    
    if (!_button_main) {
        _button_main = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _button_main;
}

/**
 *  点击搜索调到下一个界面
 */
-(void)Transmission{
    
    
    [self.view endEditing:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   

    [self addNavigationHead];

    
    
}


- (void)addNavigationHead{
    
    
    //添加主view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 25, Swidth - 80, 35)];
    
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    
    view.backgroundColor = [UIColor whiteColor];
    //添加UISearchBar
    
    UITextField *textField_main = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width - 75, 35)];
    textField_main.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField_main.font = [UIFont systemFontOfSize:15];
    
    textField_main.delegate = self;
    _textFiled_main = textField_main;
    
    UIButton *button_main = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 100, 25)];
    [button_main setImage:[UIImage imageNamed:@"Shape-48"] forState:UIControlStateNormal];
    [button_main setTitle:@"请输入名称" forState:UIControlStateNormal];
    [button_main setTitleColor:[UIColor colorWithRed:137 / 250.0 green:137 / 250.0 blue:137 / 250.0 alpha:1] forState:UIControlStateNormal];
    button_main.titleLabel.font = [UIFont systemFontOfSize:15];
    [button_main setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [textField_main addSubview:button_main];
    button_main.userInteractionEnabled = NO;
    self.button_main = button_main;
    
    [view addSubview:textField_main];
    
    
    
    //    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width - 75, 35)];
    //    search.placeholder = @"请输入名称";
    //
    //    [search setTintColor:[UIColor clearColor]];
    //
    //    [search setContentMode:UIViewContentModeRight];
    //
    //    [search setBackgroundColor:[UIColor clearColor]];
    //
    //    [search setBackgroundImage:[UIImage imageNamed:@"00008"]];
    //
    //    search.delegate = self;
    //
    
    //添加view
    
    
    
    CGFloat viewtowX =  CGRectGetMaxX(textField_main.frame);
    
    CGFloat viewtowY = CGRectGetMinY(textField_main.frame);
    
    UIView *viewtow = [[UIView alloc]initWithFrame:CGRectMake(viewtowX + 3, viewtowY + 7, 2, 20)];
    viewtow.backgroundColor = [UIColor colorWithRed:241/255 green:241/255 blue:241/255 alpha:0.1];
    
    [view addSubview:viewtow];
    
    
    
    //添加btn
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(viewtowX + 10, viewtowY, 60, 35)];
    btn.backgroundColor = [UIColor clearColor];
    
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    
    [view addSubview:btn];
    [btn setTitle:@"机构" forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(136, 136, 136, 1) forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-139-拷贝"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    CGFloat imageWidth = btn.imageView.bounds.size.width;
    CGSize sizeWidth =[MOTool sizeWithString:@"机构" font:[UIFont systemFontOfSize:15]];
    CGFloat labelWidth = sizeWidth.width;
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + 8, 0, -labelWidth);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
    
    self.navigationItem.titleView = view;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(Transmission)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    
    [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLSouTableViewCell";
    
    WLSouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    return cell;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_textFiled_main.text.length == 0) {
        self.button_main.hidden = NO;
    }
    
    
    [_textFiled_main resignFirstResponder];
    
}



#pragma mark textFile的代理方法
//开始编辑的时候调用
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.button_main.hidden = YES;
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (string.length > 0) {
        self.button_main.hidden = YES;
    }else{
        self.button_main.hidden = NO;
    }
    
    return YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.textFiled_main.text.length == 0) {
        self.button_main.hidden = NO;
    }
}




@end
