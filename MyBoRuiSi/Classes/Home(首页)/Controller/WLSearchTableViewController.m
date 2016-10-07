//
//  WLSearchTableViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSearchTableViewController.h"
#import "WLSearchTableViewCell.h"
#import "WLInstitutionLecturersCell.h"
#import "WLSouTableViewCell.h"
#import "WLCourseListCell.h"
#import "WLcardTableViewCell.h"
#import "ZGArticleCell.h"
#import "WLHomeDataHandle.h"
#import "WLSouTableViewController.h"

#import "WLCourseDetailViewController.h"
#import "WLDetailsViewController.h"
#import "WLorganVC.h"

#import "WLLecturerModel.h"
#import "WLCourceModel.h"
#import "WLInstitutionModel.h"
#import "ZGArticleModel.h"

#import "KxMenu.h"

#import "WLSharetowViewController.h"

typedef NS_ENUM(NSUInteger, ZGSearchType) {
    ZGSearchTypeCourse,         // 课程
    ZGSearchTypeLecturer,       // 讲师
    ZGSearchTypeInstitution,    // 机构
    ZGSearchTypeArticle,        // 贴子
    ZGSearchTypeStandard        // 标准
};

@interface WLSearchTableViewController ()<UISearchBarDelegate,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button_main;
@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) UITextField *textFiled_main;
@property (nonatomic, assign) ZGSearchType searchType;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, assign) BOOL isSearch;

@end

@implementation WLSearchTableViewController


- (UIButton *)button_main{

    if (!_button_main) {
        _button_main = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _button_main;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, WLScreenH - 64) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
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
    textField_main.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 35)];
    textField_main.leftViewMode = UITextFieldViewModeAlways;
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
    [btn setTitleColor:color_red forState:UIControlStateSelected];
    [btn setTitleColor:RGBA(136, 136, 136, 1) forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-139-拷贝-2"] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-139-拷贝"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    CGFloat imageWidth = btn.imageView.bounds.size.width;
    CGSize sizeWidth =[MOTool sizeWithString:@"机构" font:[UIFont systemFontOfSize:15]];
    CGFloat labelWidth = sizeWidth.width;
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + 8, 0, -labelWidth);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    _typeBtn = btn;

    //[btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
    
    self.navigationItem.titleView = view;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(Transmission)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    _isSearch = NO;
    _searchType = ZGSearchTypeInstitution;
    
    _historyArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"searchCache"]];
    
    _dataSourceArray = _historyArray;
    [self.tableView reloadData];
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

//清空
-(BOOL)textFieldShouldClear:(UITextField *)textField{

   //  [self.view endEditing:YES];
     self.button_main.hidden = NO;
    [_textFiled_main resignFirstResponder];
    
    return YES;
    
}

//点击
-(void)btnClik:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    CGFloat btnX  =  CGRectGetMaxX(btn.frame);
    CGFloat btnY  =  CGRectGetMaxY (btn.frame);
    
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"机构"
                     image:[UIImage imageNamed:@"btn_chat"]
                    target:self
                    action:@selector(btn_chat:)],
      
      [KxMenuItem menuItem:@"讲师"
                     image:[UIImage imageNamed:@"btn_addf"]
                    target:self
                    action:@selector(btn_addf:)],
      
      [KxMenuItem menuItem:@"课程"
                     image:[UIImage imageNamed:@"btn_add_saoyisao"]
                    target:self
                    action:@selector(btn_add_saoyisao:)],
      [KxMenuItem menuItem:@"帖子"
                     image:[UIImage imageNamed:@"btn_addf"]
                    target:self
                    action:@selector(btn_addArticle:)],
      [KxMenuItem menuItem:@"标准"
                     image:[UIImage imageNamed:@"btn_addf"]
                    target:self
                    action:@selector(btn_addStandard:)]];
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
//    [KxMenu showMenuInView:self.view
//                  fromRect:CGRectMake(btnX, btnY - 30, 0, 0)
//                 menuItems:menuItems];
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(btnX, btnY - 30, 0, 0) menuItems:menuItems dismissBlock:^{
        _typeBtn.selected = NO;
    }];
}
//机构
- (void)btn_chat:(id)sender{
    _typeBtn.selected = NO;
    [_typeBtn setTitle:@"机构" forState:UIControlStateNormal];
    _searchType = ZGSearchTypeInstitution;
}

/****讲师*/
- (void)btn_addf:(id)sender{
    _typeBtn.selected = NO;
    [_typeBtn setTitle:@"讲师" forState:UIControlStateNormal];
    _searchType = ZGSearchTypeLecturer;
}

/***课程**/
- (void)btn_add_saoyisao:(id)sender{
    _typeBtn.selected = NO;
    [_typeBtn setTitle:@"课程" forState:UIControlStateNormal];
    _searchType = ZGSearchTypeCourse;
}

- (void)btn_addArticle:(id)sender
{
    _typeBtn.selected = NO;
    [_typeBtn setTitle:@"帖子" forState:UIControlStateNormal];
    _searchType = ZGSearchTypeArticle;
}

- (void)btn_addStandard:(id)sender
{
    _typeBtn.selected = NO;
    [_typeBtn setTitle:@"标准" forState:UIControlStateNormal];
    _searchType = ZGSearchTypeStandard;
}

////点击屏幕退出
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  点击搜索调到下一个界面
 */
- (void)Transmission
{
    [self.view endEditing:YES];
    _isSearch = YES;
    if (_textFiled_main.text.length > 0) {
        [_historyArray addObject:_textFiled_main.text];
        [[NSUserDefaults standardUserDefaults] setObject:_historyArray forKey:@"searchCache"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [MOProgressHUD showWithStatus:@"正在搜索..."];
    _dataSourceArray = @[];
    switch (_searchType) {
            
        case ZGSearchTypeCourse:
        case ZGSearchTypeStandard: // 标准也调用课程
        {
            [WLHomeDataHandle requestSearchCourseWithNum:@10 page:@1 key:_textFiled_main.text type:@0 ppid:@"" priceOrder:@"" zbstatus:@1 saleNum:@"asc" level:@0 success:^(id responseObject) {
                
                _dataSourceArray = [WLCourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.tableView reloadData];
                [MOProgressHUD dismiss];

            } failure:^(NSError *error) {
                [MOProgressHUD dismiss];
            }];
        }
            break;
        case ZGSearchTypeLecturer:
        {
            [WLHomeDataHandle requestSearchLecturerWithNum:@10 page:@1 key:_textFiled_main.text success:^(id responseObject) {
                
                _dataSourceArray = [WLLecturerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.tableView reloadData];
                [MOProgressHUD dismiss];

            } failure:^(NSError *error) {
                [MOProgressHUD dismiss];
            }];
        }
            break;
        case ZGSearchTypeInstitution:
        {
            [WLHomeDataHandle requestSearchInstitutionWithNum:@10 page:@1 key:_textFiled_main.text success:^(id responseObject) {
                
                _dataSourceArray = [WLInstitutionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.tableView reloadData];
                [MOProgressHUD dismiss];

            } failure:^(NSError *error) {
                [MOProgressHUD dismiss];
            }];
        }
            break;
        case ZGSearchTypeArticle:
        {
            [WLHomeDataHandle requestSearchArticleWithNum:@10 page:@1 key:_textFiled_main.text success:^(id responseObject) {
                
                NSMutableArray *mArray = [NSMutableArray array];
                
                for (NSDictionary *dic in responseObject[@"data"]) {
                    
                    ZGArticleModel *article = [ZGArticleModel mj_objectWithKeyValues:dic];
                    ZGArticleViewModel *vModel = [[ZGArticleViewModel alloc] init];
                    vModel.article = article;
                    [mArray addObject:vModel];
                }
                _dataSourceArray = mArray;
                [self.tableView reloadData];
                [MOProgressHUD dismiss];

            } failure:^(NSError *error) {
                [MOProgressHUD dismiss];
            }];
        }
            break;
        default:
            break;
    }
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
    return _dataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *searchCell = nil;
    
    if (!_isSearch) {
        
        static NSString *deteID = @"WLSearchTableViewCell";
        WLSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
        }
        cell.Lableview.text = _dataSourceArray[indexPath.row];
        searchCell = cell;
        return searchCell;
    }

    switch (_searchType) {
            
        case ZGSearchTypeCourse:
        {
            static NSString *ID = @"courceCell";
            WLCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[WLCourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.course = _dataSourceArray[indexPath.row];
            searchCell =  cell;
        }
            break;
        case ZGSearchTypeLecturer:
        {
            static NSString *ID = @"lecturerCell";
            WLInstitutionLecturersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[WLInstitutionLecturersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.lecturer = _dataSourceArray[indexPath.row];
            searchCell =  cell;
        }
            break;
        case ZGSearchTypeInstitution:
        {
            static NSString *ID = @"institutionCell";
            WLSouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"WLSouTableViewCell" owner:nil options:nil] lastObject];
            }
            cell.institution = _dataSourceArray[indexPath.row];
            searchCell =  cell;
        }
            break;
        case ZGSearchTypeArticle:
        {
            static NSString *ID = @"articleCell";
            ZGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[ZGArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.articleViewModel = _dataSourceArray[indexPath.row];
            searchCell =  cell;
        }
            break;
        case ZGSearchTypeStandard:
        {
            static NSString *ID = @"courceCell";
            WLCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[WLCourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.course = _dataSourceArray[indexPath.row];
            searchCell =  cell;
        }
            break;

        default:
            break;
    }
    return searchCell;
}

//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_isSearch) {
        return 50;
    }
    CGFloat height;
    switch (_searchType) {
            
        case ZGSearchTypeCourse:
        case ZGSearchTypeLecturer:
        case ZGSearchTypeInstitution:
        {
            height = 100;
        }
            break;
        case ZGSearchTypeArticle:
        {
            height = [_dataSourceArray[indexPath.row] cellHeight];
        }
            break;
        case ZGSearchTypeStandard:
        {
            height = 100;
        }
            break;
            
        default:
            break;
    }
    return height;
}


//返回组头view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (_isSearch) {
        return [UIView new];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, 40)];
    view.backgroundColor = KColorBackgroud;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 40)];
    label.text = @"历史搜索";
    label.textColor = COLOR_BLACK;
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSearch) {
        return 0.000001;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
    {
        CGRect r= CGRectMake(1.0f, 1.0f, 1.0f, height);
        UIGraphicsBeginImageContext(r.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, r);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!_isSearch) {
        return;
    }
    
    switch (_searchType) {
            
        case ZGSearchTypeCourse:
        case ZGSearchTypeStandard:
        {
            WLCourseDetailViewController *vc = [[WLCourseDetailViewController alloc] init];
            vc.courseId = [_dataSourceArray[indexPath.row] id];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ZGSearchTypeLecturer:
        {
            WLDetailsViewController *vc = [[WLDetailsViewController alloc] init];
            vc.teacherId = [_dataSourceArray[indexPath.row] id];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ZGSearchTypeInstitution:
        {
            WLorganVC *vc = [[WLorganVC alloc] init];
            vc.institutionId = [_dataSourceArray[indexPath.row] id];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ZGSearchTypeArticle:
        {
            
        }
            break;
        default:
            break;
    }

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航控制器导航上的背景图片，并且拉伸
    [self.navigationController.navigationBar setBackgroundImage:[UIImage cleImage:[UIColor colorWithRed:139.0/255 green:23.0/255 blue:55.0/255 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    
    if (self.textFiled_main.text.length == 0) {
        self.button_main.hidden = NO;
    }
}


@end
