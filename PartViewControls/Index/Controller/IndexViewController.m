//
//  IndexViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexCollectionViewCell.h"
//#import "IWTabBarController.h"

@interface IndexViewController ()

@property (nonatomic, weak) UIPageControl *control;

@end

@implementation IndexViewController;

static NSString *ID = @"cell";
- (instancetype)init
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 清空行距
    layout.minimumLineSpacing = 0;
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}


// 使用UICollectionViewController
// 1.初始化的时候设置布局参数
// 2.必须collectionView要注册cell
// 3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 注册cell,默认就会创建这个类型的cell
    [self.collectionView registerClass:[IndexCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
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
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor whiteColor];
    control.currentPageIndicatorTintColor = TCColor;
    
    control.bounds = CGRectMake(0, 0, 70, 20);
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height*0.95);
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
#pragma mark - UICollectionView代理和数据源
// 返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;////
}



// 返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // dequeueReusableCellWithReuseIdentifier
    // 1.首先从缓存池里取cell
    // 2.看下当前是否有注册Cell,如果注册了cell，就会帮你创建cell
    // 3.没有注册，报错
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    // 拼接图片名称 3.5 320 480
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    if (screenH > 480) { // 5 , 6 , 6 plus
        
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
        
    }
    cell.image = [UIImage imageNamed:imageName];
    
    //[cell setIndexPath:indexPath count:4];
    /*thrsthrt*/
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item ==3) {
//        IWTabBarController *mainVc = [[IWTabBarController alloc] init];
        MyTabbarViewController *mainVc = [[MyTabbarViewController alloc]init];
        
        // 切换根控制器:可以直接把之前的根控制器清空
        TCKeyWindow.rootViewController = mainVc;
    }
    else
    {
        return;
    }
}



@end