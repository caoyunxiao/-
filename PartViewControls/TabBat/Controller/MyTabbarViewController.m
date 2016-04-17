//
//  MyTabbarViewController.m
//  Caoyunxiao
//
//  Created by 曹云霄 on 15/12/28.
//  Copyright © 2015年 曹云霄. All rights reserved.
//

#import "MyTabbarViewController.h"
#import "TChomeViewController.h"
#import "MyButton.h"
#import "TCHomeViewController.h"
#import "ShowViewController.h"
#import "OnlineViewController.h"
#import "WelfareViewController.h"
#import "MyInforViewController.h"
#import "LGIndexViewController.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height 49
#define NewHeight [UIScreen mainScreen].bounds.size.height

@interface MyTabbarViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSArray *TitleArray;
@property (nonatomic,strong) NSArray *controlArray;

@end



@implementation MyTabbarViewController


- (NSArray *)TitleArray
{
    if (_TitleArray == nil) {
        
        _TitleArray = [NSArray arrayWithObjects:@"首页",@"商场",@"梦想",@"福利",@"我的",nil];
    }
    return _TitleArray;
}


- (UIImageView *)imageview
{
    if (_imageview == nil) {
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, -9, self.tabBar.frame.size.width, self.tabBar.frame.size.height+8)];
        _imageview.image = [UIImage imageNamed:@"tabbar_bg"];
        _imageview.userInteractionEnabled = YES;
    }
    return _imageview;
}


- (NSArray *)controlArray
{
    if (_controlArray == nil) {
        
        _controlArray = [NSArray arrayWithObjects:@"TCHomeViewController",@"OnlineViewController",@"ShowViewController",@"WelfareViewController",@"MyInforViewController", nil];
    }
    return _controlArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uiConfigAction];
    [self uiConfigActionButton];
    
}


- (void)uiConfigAction
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<self.controlArray.count; i++) {
        
        UIViewController *MyController = [[NSClassFromString(self.controlArray[i]) alloc]init];
        UINavigationController *Nav = [[UINavigationController alloc]initWithRootViewController:MyController];
        Nav.interactivePopGestureRecognizer.delegate = self;
        MyController.title = self.TitleArray[i];
        [array addObject:Nav];
    }
    self.viewControllers = array;
}


- (void)uiConfigActionButton
{
    /**
     *  隐藏tabbar上面的横线
     */
    self.tabBar.barStyle = UIBarStyleBlackOpaque;
    
    [self.tabBar addSubview:self.imageview];
    NSArray *NomelimageArray = [NSArray arrayWithObjects:@"tabbar_home",@"tabbar_online",@"tabbar_show",@"tabbar_welfare",@"tabbar_myinfo", nil];
    NSArray *SelectimageArray = [NSArray arrayWithObjects:@"tabbar_home_select",@"tabbar_online_select",@"tabbar_show_select",@"tabbar_welfare_select",@"tabbar_myinfo_select", nil];
    
    for (int i=0; i<NomelimageArray.count; i++) {
        
        MyButton *button = [MyButton buttonWithType:UIButtonTypeCustom];
        button.indexButton = i;
        button.frame = CGRectMake(Width/5*i, 0, Width/5, Height);
        [button setImage:[UIImage imageNamed:NomelimageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:SelectimageArray[i]] forState:UIControlStateSelected];
        [button setTitle:_TitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:TCColordefault forState:UIControlStateNormal];
        [button setTitleColor:TCColor forState:UIControlStateSelected];
        button.tag = 100 +i;
        if (i == 0) {
            
            button.selected = YES;
        }
        [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageview addSubview:button];
    }
}


- (void)ButtonClick:(MyButton *)btn
{
    /**
     *  判断是否登录
     */
    if (![PersonInfo sharePersonInfo].isLogIn && btn.tag-100 == 4) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            LGIndexViewController *lvc = [[LGIndexViewController alloc]init];
            lvc.isPresent = YES;
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
            nvc.interactivePopGestureRecognizer.delegate = self;
            [self presentViewController:nvc animated:YES completion:nil];
        });
        
    }else
    {
        
        for (UIView *view in btn.superview.subviews) {
            
            if ([view isKindOfClass:[MyButton class]]) {
                
                MyButton *button = (MyButton *)view;
                button.selected = NO;
            }
        }
        
        /**
         弹出发布梦想秀悬浮框
         */
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@(btn.tag-100),@"selectedIndex", nil];
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"SELECTED_INDEX" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        self.selectedIndex = btn.tag - 100;
        btn.selected = YES;
    }
}




@end
