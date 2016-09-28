//
//  WLCurriculum.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCurriculum.h"
#import "WLCurriculumTableViewCell.h"
#import "WLCurriculumTableViewCellTwo.h"
#import "WLCurriculumTableViewThreeCell.h"
#import "LiveTableViewTwoCell.h"
#import "LiveTableViewCell.h"

#import "DirectSeedingViewController.h"
#import "WLVODCourseListViewController.h"

#import "ZGCourseTypeModel.h"
#import "WLLiveCourseTypeCell.h"
#import "WLZxzbViewController.h"
#import "WLCourseDataHandle.h"
#import "WLCourseTypeCell.h"
#import "MOHTTP.h"

@interface WLCurriculum ()

@property(nonatomic,strong) NSArray *segmentedArray;

@property (nonatomic,assign)int num;

@property (strong, nonatomic) IBOutlet UITableView *tableView_main;

@property (nonatomic,strong) NSMutableArray *array_main;

@property (nonatomic, strong) NSArray *hotCourseArray;
@property (nonatomic, strong) NSArray *recommendArray;


@end

@implementation WLCurriculum

- (NSMutableArray *)array_main{
    
    
    if (!_array_main) {
        _array_main = [NSMutableArray array];
    }
    return _array_main;
    
}

-(NSArray *)segmentedArray{
    if (_segmentedArray == nil) {
        _segmentedArray = [[NSArray alloc]init];
    }
    return _segmentedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     //设置背景图片
    
    self.array_main = [NSMutableArray arrayWithObjects:@"游戏开发",@"证书考试",@"软件开发",@"云计算",@"企业课程",@"考试培训",@"其它", nil];
    _num = 0;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(139, 34, 56, 1)] forBarMetrics:UIBarMetricsDefault];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"点播",@"直播",nil];
    
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(28, 23, 88, 33);
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor whiteColor];
    [segmentedControl addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    
    [self requestData];
}

- (void)requestData
{
    [WLCourseDataHandle requestHotCourseTypeSuccess:^(id responseObject) {
        
        _hotCourseArray = [ZGCourseTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [WLCourseDataHandle requestRecommendCourseTypeSuccess:^(id responseObject) {
        
        _recommendArray = [ZGCourseTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)selected:(id)sender{
    
    UISegmentedControl* control = (UISegmentedControl*)sender;
    
    _num = (int)control.selectedSegmentIndex;
    [self.tableView_main reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    int num = 2;
    if (_num == 1) {
        
        if (section == 0) {
            num = 3;
        }
        
    }
    
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"WLCourseTypeCell.h";
    static NSString *IDTwo = @"WLCurriculumTableViewCellTwo";
    static NSString *IDThree = @"WLCurriculumTableViewThreeCell";
    static NSString *IDFour = @"LiveTableViewCell";
    static NSString *IDFive = @"LiveTableViewTwoCell";
    
    __weak typeof(self) weakSelf = self;
    id cell;
    
    WLCourseTypeCell *cellsF = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cellsF) {
        cellsF = [[WLCourseTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
   WLCurriculumTableViewCellTwo  *cellTwo = [tableView dequeueReusableCellWithIdentifier:IDTwo];
    if (!cellTwo) {
        cellTwo = [[[NSBundle mainBundle] loadNibNamed:IDTwo owner:nil options:nil] lastObject];
    }
    
    WLCourseTypeCell  *cellThree = [tableView dequeueReusableCellWithIdentifier:IDThree];
    if (!cellThree) {
        cellThree =  [[WLCourseTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDThree];
    }
    
    LiveTableViewCell  *cellFour = [tableView dequeueReusableCellWithIdentifier:IDFour];
    if (!cellFour) {
        cellFour = [[[NSBundle mainBundle] loadNibNamed:IDFour owner:nil options:nil] lastObject];
    }
    
    WLLiveCourseTypeCell *cellFive = [tableView dequeueReusableCellWithIdentifier:IDFive];
    if (!cellFive) {
        cellFive =[[WLLiveCourseTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDFive];
    }
    
    
    UITableViewCell *cellSix = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    if (indexPath.section == 0) {
        
        if (_num == 1) {
            if (indexPath.row == 0) {
                
                cellSix.textLabel.text = @"正在直播";
                cell = cellSix;
            }else if(indexPath.row == 1) {
                
                cellFour.imageName.image = [UIImage imageNamed:@"001"];
                
                cell = cellFour;
                //在线直播
                cellFour.WLiveTableViewCellBlcok = ^(){
                    
                    WLZxzbViewController *zxvc = [[WLZxzbViewController alloc]init];
                    [self.navigationController pushViewController:zxvc animated:YES];
                    
                    
                };

                
            }else{
                
                cellFour.imageName.image = [UIImage imageNamed:@"002"];
                
                cell = cellFour;
                
                
                //@@@@@
                
                //在线直播
//
                cellFour.WLiveTableViewCellBlcok = ^(){
                    
                    WLZxzbViewController *zxvc = [[WLZxzbViewController alloc]init];
                    [self.navigationController pushViewController:zxvc animated:YES];

                    
                };

            }

        }else{
            
            if (indexPath.row == 0) {
                
                
                cellTwo.label_main.text = @"热门课程";
                cellTwo.imageName.image = [UIImage imageNamed:@"矢量智能对象"];
                
                
                cell = cellTwo;
                
            }else{

                cellsF.typeArray = _hotCourseArray;
                [cellsF setBlock:^(NSString *typeId) {
//                    DirectSeedingViewController *direct = [[DirectSeedingViewController alloc] init];
//                    [weakSelf.navigationController pushViewController:direct animated:YES];
                    WLVODCourseListViewController *vc = [[WLVODCourseListViewController alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
//                    UIImage *image = [UIImage imageNamed:@"矢量智能对象"];
//                    NSData *data = UIImagePNGRepresentation(image);
//                   
//                    [MOHTTP Post:@"API/index.php?action=Upload&do=appUpload" parameters:@{@"uid":[WLUserInfo share].userId,@"Filedata":data} success:^(id responseObject) {
//                        
//                    } failure:^(NSError *error) {
//                        
//                    }];
                }];
                cell = cellsF;
            }
        }
    }else{
        if (_num == 1) {
            if (indexPath.row == 0) {
                
                cellTwo.label_main.text = @"热门课程";
                cellTwo.imageName.image = [UIImage imageNamed:@"矢量智能对象"];
                cell = cellTwo;
                
            }else{
                
                cellFive.typeArray = _hotCourseArray;
                [cellFive setBlock:^(NSString *typeId) {
                    WLZxzbViewController *zxvc = [[WLZxzbViewController alloc]init];
                    [self.navigationController pushViewController:zxvc animated:YES];

                }];
                cell = cellFive;
            }
        }else{
            if (indexPath.row == 0) {
                
                cellTwo.label_main.text = @"推荐课程";
                cellTwo.imageName.image = [UIImage imageNamed:@"推荐"];
                cell = cellTwo;
                
            }else{
                
                cellThree.typeArray = _recommendArray;
                [cellThree setBlock:^(NSString *typeId) {
                    WLVODCourseListViewController *vc = [[WLVODCourseListViewController alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];

//                    DirectSeedingViewController *direct = [[DirectSeedingViewController alloc] init];
//                    [weakSelf.navigationController pushViewController:direct animated:YES];

                }];
                cell = cellThree;
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    int a = 50;
    
    if (_num == 1) {
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                
            }else{
                
                a = 100;
            }
            
        }else{
            
            if (indexPath.row == 0) {
                
                
            }else{
                a = 220;
            }
        }
    }else{
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
            }else{
                
                a = 190;
            }
        }else{
            
            if (indexPath.row == 0) {
                
            }else{
                
                a = 100;
            }
        }
    }
    return a;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 10;
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(139.0, 23.0, 55.0, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
}




@end
