//
//  CZNewfeatureController.m
//  大微博5
//
//  Created by wsl on 16/6/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZNewfeatureController.h"
#import "CZNewFeatureCell.h"

@interface CZNewfeatureController ()


@property (nonatomic, weak) UIPageControl *control;


@end

@implementation CZNewfeatureController

static NSString * ID  = @"Cell";

-(instancetype)init

{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空行距
    layout.minimumLineSpacing = 0;
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    

    
    return [super initWithCollectionViewLayout:layout];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CZNewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    
    // 分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 添加pageController
    [self setUpPageControl];
    
}
// 添加pageController
- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 3;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height-=20);
    _control = control;
    [self.view addSubview:control];
}

#pragma mark - UIScrollView代理
// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // dequeueReusableCellWithReuseIdentifier
    // 1.首先从缓存池里取cell
    // 2.看下当前是否有注册Cell,如果注册了cell，就会帮你创建cell
    // 3.没有注册，报错
    CZNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    // 拼接图片名称 3.5 320 480
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"GuidePage-%ld",indexPath.row + 1];
    if (screenH > 480) { // 5 , 6 , 6 plus
        imageName = [NSString stringWithFormat:@"GuidePage-%ld",indexPath.row + 1];
    }
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:3];
    
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
