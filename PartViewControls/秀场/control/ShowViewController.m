//
//  ShowViewController.m
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowCell.h"
#import "ReleaseRreamsViewController.h"

#import "PublishedPhotosViewController.h"
#import "SCNavigationController.h"
#import "TCNewDetailViewController.h"
#import "LoadingButton.h"
#import "LoadDataVideoZFJ.h"
#import "DreamHistoryDetailViewController.h"
#import <ALBBQuPaiPlugin/ALBBQuPaiPluginPluginServiceProtocol.h>
#import <TAESDK/TAESDK.h>

#import "ZuiXinViewController.h"        //分页控制器的视图控制器
@interface ShowViewController ()<SCNavigationControllerDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,ZuiXinViewControllerDelegate>
{
    //数据源
    NSMutableArray *_vcArray;
    //btn遮罩层
    UIView *_indicatorView;
    UIPageViewController *_pageViewController;
     NSInteger _curPage;
}
@end

@implementation ShowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTopbar];
    [self initVcArr];
    [self initPageVC];
    [self configUI];
    [self showDreamMenu];
    [self configureNotification:YES];
}

#pragma mark - 创建顶部导航条
- (void)createTopbar
{
    NSArray *titleArr = @[@"最新",@"最美走道",@"最美行者",@"胖友跑",@"奇葩跑",@"最热",@"已完成"];
    
    for (NSInteger i = 0; i<7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(3+i*100, 3, 100, 30);
        if (i == 0) {
            
            btn.frame = CGRectMake(50+i*[self INcomingStringReturn:titleArr[i]], 2, [self INcomingStringReturn:titleArr[i]], 30);
            [btn setTitleColor:TCColor forState:UIControlStateNormal];
        }else
        {
            UIButton *firstButtton = [self.view viewWithTag:100+i-1];
            btn.frame = CGRectMake(firstButtton.frame.origin.x+firstButtton.frame.size.width+50, 3, [self INcomingStringReturn:titleArr[i]], 30);
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        
        [btn setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1.0]];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_topScrollView addSubview:btn];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton *lastButton = [self.view viewWithTag:106];
    UIButton *oneButton = [self.view viewWithTag:100];
    _topScrollView.contentSize = CGSizeMake(lastButton.frame.size.width+lastButton.frame.origin.x+50, 0);
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(oneButton.frame.origin.x, _topScrollView.frame.size.height-5,oneButton.frame.size.width, 2)];
    _indicatorView.backgroundColor = TCColor;
    [_topScrollView addSubview:_indicatorView];
}


/**
 *  计算字符串长度
 *
 *  @return
 */
- (CGFloat)INcomingStringReturn:(NSString *)Str
{
    CGFloat width = [Str boundingRectWithSize:CGSizeMake(9999, 30) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
    return width;
}


#pragma mark - ChangeVc
- (void)changeVC:(UIButton *)btn
{
    //获取当前第几页
    
    NSInteger tag = btn.tag - 100;
    [self incomingTagNumber:tag];
    
    
    [_pageViewController setViewControllers:@[_vcArray[tag]] direction:tag<_curPage animated:YES completion:^(BOOL finished) {
        _curPage=tag;
    }];

}
#pragma mark - 初始化所有的视图控制器
- (void)initVcArr
{
    _vcArray = [NSMutableArray array];
    NSArray *sorting = @[@"1",@"13",@"12",@"14",@"15",@"2",@"3"];
    for (NSInteger i = 0; i<7; i++) {
        ZuiXinViewController *vc = [[ZuiXinViewController alloc]init];
        
        vc.delegate = self;
        vc.sorting = sorting[i];

        [_vcArray addObject:vc];
    }
}
#pragma mark - 初始化视图控制器数组
- (void)initPageVC
{
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    
    //设置显示的viewcontrollers
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height-35);
    
    [self.view addSubview:_pageViewController.view];
    
    for (UIView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delegate = self;
        }
    }
}

#pragma mark - PageViewControllerDelegate
//返回后一页数据
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //获取当前页数
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index+1 == _vcArray.count) {
        return nil;
    }
    return _vcArray[index+1];
}

//返回前一页数据
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    
    return _vcArray[index-1];
}

//滚动结束代理函数
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    _curPage = [_vcArray indexOfObject:pageViewController.viewControllers[0]];
    [self incomingTagNumber:_curPage];
}


/**
 *  传入按钮Tag值
 *
 *  @return  改变按钮字体颜色，移动指示线条
 */
- (void)incomingTagNumber:(NSInteger)Tag
{
    UIButton *currentButton = (UIButton *)[self.view viewWithTag:100+Tag];
    [UIView animateWithDuration:0.3 delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _indicatorView.frame = CGRectMake(currentButton.frame.origin.x, _topScrollView.frame.size.height-5, currentButton.frame.size.width, 2);
        
    } completion:^(BOOL finished) {
        
        /**
         *  改变颜色
         */
        for (int i=0; i<_vcArray.count; i++) {
            
            UIButton *button = (UIButton *)[self.view viewWithTag:100+i];
            if (i == Tag) {
                button.titleLabel.textColor = TCColor;
            }else
            {
                button.titleLabel.textColor = [UIColor grayColor];
            }
        }
        /**
         *  判断scrollView是否需要偏移
         */
        /**
         *  下一个按钮
         */
        UIButton *nextButton = [self.view viewWithTag:Tag<=5?Tag+1:Tag];
        /**
         *  上一个按钮
         */
        UIButton *TopButton = [self.view viewWithTag:Tag<=0?Tag:Tag-1];
        NSLog(@"--------%f,%f",TopButton.frame.origin.x+TopButton.frame.size.width+50-_topScrollView.contentOffset.x,ScreenWidth);
        if (currentButton.frame.origin.x+currentButton.frame.size.width+nextButton.frame.origin.x+nextButton.frame.size.width - _topScrollView.contentOffset.x >= ScreenWidth) {
            
            [_topScrollView setContentOffset:CGPointMake(currentButton.frame.origin.x+currentButton.frame.size.width+nextButton.frame.origin.x+nextButton.frame.size.width-ScreenWidth+50, 0) animated:YES];
            
        }else
        {
            if (TopButton.frame.origin.x- ScreenWidth <=0 && _topScrollView.contentOffset.x >= 0)
            {
                [_topScrollView setContentOffset:CGPointMake((_topScrollView.contentOffset.x-TopButton.frame.size.width-50)<0?0:(_topScrollView.contentOffset.x-TopButton.frame.size.width-50), 0) animated:YES];
            }
        }
    }];
}



#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /**
     *  取消滑动
     */
    if (_curPage == 0) {
        
        if (scrollView.contentOffset.x <= ScreenWidth ) {
            
            [scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
       }
    }else if (_curPage == _vcArray.count-1)
    {
        if (scrollView.contentOffset.x >= ScreenWidth) {
            
            [scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
        }
    }
    
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    //offset初值为当前屏幕宽度，结束滚动时值也为当前屏幕宽度
//    CGPoint offSet = scrollView.contentOffset;
//    CGFloat width = self.view.frame.size.width;
//    CGFloat ratio = 100/width;
//    CGRect frame = _indicatorView.frame;
//    frame.origin.x = (offSet.x-width)*ratio + _curPage*100;
//    [UIView animateWithDuration:0.3 animations:^{
//         _indicatorView.frame = frame;
//        
//    }completion:^(BOOL finished) {
//        
//        CGFloat maxX = CGRectGetMaxX(_indicatorView.frame);
//        CGRect topScrollViewFrame = _topScrollView.frame;
//        if (maxX >= topScrollViewFrame.size.width) {
//            _topScrollView.contentOffset = CGPointMake(maxX-topScrollViewFrame.size.width, 0);
//        }
//    }];
//    _indicatorView.frame = frame;

}


#pragma mark - 设置配置文件
- (void)configUI
{
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedIndex:) name:@"SELECTED_INDEX" object:nil];
    _loadButton = [[[NSBundle mainBundle] loadNibNamed:@"LoadingButton" owner:self options:nil] lastObject];
    _loadButton.frame = CGRectMake(0, 0, 40, 35);
    _loadButton.clipsToBounds = YES;
    UIBarButtonItem *loadBtn = [[UIBarButtonItem alloc]initWithCustomView:_loadButton];
    self.navigationItem.rightBarButtonItem = loadBtn;
    _loadButton.hidden = YES;
}


- (void)selectedIndex:(NSNotification *)text
{
    NSInteger selectedIndex = [text.userInfo[@"selectedIndex"] integerValue];
    if(selectedIndex==2)
    {
        [self showDreamMenu];
    }
}


- (void)showDreamMenu
{
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    [menuView addMenuItemWithTitle:nil andIcon:[UIImage imageNamed:@"icon_camera"] andSelectedBlock:^{

        if (![self Determinethecamerapermissions]) {
            
            Alert(@"请先去设置->隐私->相机中开启<咖范@宣言>权限");
            return ;
        }
        
        if (![PersonInfo sharePersonInfo].isLogIn) {
            
            [self showLogInViewController];
            return;
        }
        //获取用户是否有梦想正在进行中
//        NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
        
         NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
        
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"509" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            if([errorCode isEqualToString:@"0"])
            {
                
                Alert(@"你已发布过梦想");
                return ;
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    SCNavigationController *nav = [[SCNavigationController alloc] init];
                    nav.scNaigationDelegate = self;
                    nav.ISME = NO;
                    [nav showCameraWithParentController:self];
                    
                });

            }
        }];

    }];
    
    [menuView addMenuItemWithTitle:nil andIcon:[UIImage imageNamed:@"icon_film"] andSelectedBlock:^{
        
        
        if (![self Determinethecamerapermissions]) {
            
           Alert(@"请先去设置->隐私->相机中开启<咖范@宣言>权限");
            return ;
        }
        if (![PersonInfo sharePersonInfo].isLogIn) {
            
            [self showLogInViewController];
            return;
        }
        //获取用户是否有梦想正在进行中
       //NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
        
         NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
        
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"509" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            if([errorCode isEqualToString:@"0"])
            {
                
                Alert(@"你已发布过梦想");
                return ;
            }
            else
            {
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
                id<ALBBQuPaiPluginPluginServiceProtocol> sdk = [[TaeSDK sharedInstance] getService:@protocol(ALBBQuPaiPluginPluginServiceProtocol)];
                [sdk setDelegte:(id<QupaiSDKDelegate>)self];
                UIViewController *recordController = [sdk createRecordViewControllerWithMaxDuration:20.0
                                                                                            bitRate:800*1000
                                                                        thumbnailCompressionQuality:1.0
                                                                                     watermarkImage:kWaterImage
                                                                                  watermarkPosition:QupaiSDKWatermarkPositionTopRight
                                                                                          tintColor:TCColor
                                                                                    enableMoreMusic:NO
                                                                                       enableImport:YES
                                                                                  enableVideoEffect:YES];
                
                navigation = [[UINavigationController alloc] initWithRootViewController:recordController];
                navigation.navigationBarHidden = YES;
                [self presentViewController:navigation animated:YES completion:nil];
            }
        }];

    }];
    
    [menuView addMenuItemWithTitle:nil andIcon:[UIImage imageNamed:@"icon_logo"] andSelectedBlock:^{
        NSLog(@"icon_logo");
    }];
    [menuView show];
}


#pragma amrk -录制视频回调
- (void)qupaiSDK:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    if (videoPath == nil) {
        
        return;
    }
    NSLog(@"2Qupai SDK compelete %@",videoPath);
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
    }
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
    
    PublishedPhotosViewController *rvc = [[PublishedPhotosViewController alloc]init];
    rvc.videoFileURL = [NSURL fileURLWithPath:videoPath];
    rvc.VideoString = videoPath;
    rvc.resourceType = @"video";
    [navigation pushViewController:rvc animated:YES];
}



#pragma mark -音乐
//- (NSArray *)qupaiSDKMusics:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk
//{
//    NSArray *array = @[@"",@"",@""];
//    return array;
//}


#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_dataArray[[_sorting integerValue]] count];
}

#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 309;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str = @"ShowCell";
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShowCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    if ([_dataArray[[_sorting integerValue]] count]!= 0) {
        
        [cell showUIViewWithModelForNew:_dataArray[[_sorting integerValue]][indexPath.row]];
    }
    return cell;
}



#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![PersonInfo sharePersonInfo].isLogIn) {
        [self showLogInViewController];
        return;
    }
//    HomeModel *Model = [[HomeModel alloc]init];
    //判断当前梦想是否正在进行中

    HomeModel *Model = _dataArray[[_sorting integerValue]][indexPath.row];
    
    if ([Model.state intValue] == 1) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TCNewDetailViewController *tvc = [[TCNewDetailViewController alloc]init];
        
        tvc.dreamID = Model.dreamID;
        
        [self.navigationController pushViewController:tvc animated:YES];
    }
    else
    {
        DreamHistoryDetailViewController *dream = [[DreamHistoryDetailViewController alloc]init];
        dream.dreamID = Model.dreamID;
        [self.navigationController pushViewController:dream animated:YES];
    }
}

#pragma mark -界面将要显示时
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 以下是相机相关
- (void)dealloc {
    

    [self configureNotification:NO];
}
- (void)configureNotification:(BOOL)toAdd {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTakePicture object:nil];
    if (toAdd) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackNotificationForFilter:) name:kNotificationTakePicture object:nil];
    }
}

- (void)callbackNotificationForFilter:(NSNotification*)noti
{
//    UIViewController *cameraCon = noti.object;
//    if (!cameraCon) {
//        return;
//    }
//    UIImage *finalImage = [noti.userInfo objectForKey:kImage];
//    if (!finalImage) {
//        return;
//    }
//    BaseViewController *con = [[BaseViewController alloc] init];
//    con.postImage = finalImage;
//    
//    if (cameraCon.navigationController) {
//        [cameraCon.navigationController pushViewController:con animated:YES];
//    } else {
//        [cameraCon presentViewController:con animated:YES completion:nil];
//    }
}
#pragma mark - SCNavigationController delegate
- (void)didTakePicture:(SCNavigationController *)navigationController imagearr:(NSArray *)imagearr
{
    
    PublishedPhotosViewController *rvc = [[PublishedPhotosViewController alloc]init];
    rvc.imageArray = imagearr;
    rvc.resourceType = @"photo";
    [navigationController pushViewController:rvc animated:YES];
}

#pragma mark - zuixinViewController代理方法
- (void)ZuiXinViewControllerDidSelectRowAtIndexPath:(NSIndexPath *)indexPath array:(NSArray *)array
{
        if (![PersonInfo sharePersonInfo].isLogIn) {
            [self showLogInViewController];
            return;
        }
//        HomeModel *Model = [[HomeModel alloc]init];
        //判断当前梦想是否正在进行中
    
        HomeModel *Model = array[indexPath.row];
    
        if ([Model.state intValue] == 1) {
    
        
            TCNewDetailViewController *tvc = [[TCNewDetailViewController alloc]init];
    
            tvc.dreamID = Model.dreamID;
            tvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tvc animated:YES];
        }
        else
        {
            DreamHistoryDetailViewController *dream = [[DreamHistoryDetailViewController alloc]init];
            dream.dreamID = Model.dreamID;
            dream.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dream animated:YES];
        }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





@end
