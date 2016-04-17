//
//  VedioDetailViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/20.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "VedioDetailViewController.h"
#import "HistoryPlayer.h"
#import "JZVideoPlayerView.h"

#import "AppDelegate.h"

// 4.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface VedioDetailViewController ()<JZPlayerViewDelegate>
{
    JZVideoPlayerView *_jzPlayer;
}

@end

@implementation VedioDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self initPlayer];
        [self initJZPlayer];
    });
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*混凝土任何内容太难华南虎哥你好呢太难听和你特怀念他人妖你人妖呢*/


-(void)initJZPlayer{
    NSURL *url = [NSURL URLWithString:self.FileUrl];
    _jzPlayer = [[JZVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) contentURL:url];
    _jzPlayer.delegate = self;
    [self.view addSubview:_jzPlayer];
    [_jzPlayer play];
}


//屏幕旋转
-(BOOL)shouldAutorotate{
    return YES;
}
//支持旋转的方向
//一开始的屏幕旋转方向
//支持旋转的方向
//一开始的屏幕旋转方向
- (NSUInteger)supportedInterfaceOrientations
{
    NSLog(@"11222111111");
    
    return UIInterfaceOrientationLandscapeLeft;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"11111111");
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [UIView animateWithDuration:0 animations:^{
        if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
            _jzPlayer.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
        }else{
            _jzPlayer.frame = CGRectMake(0, 0, self.view.frame.size.height, ScreenWidth);
        }
    } completion:^(BOOL finished){
        
    }];
}



-(void)playerViewZoomButtonClicked:(JZVideoPlayerView *)view{
    //强制横屏
    NSLog(@"222222");
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationPortrait;//
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }else{
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationLandscapeRight;//
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
    }
}

#pragma mark - JZPlayerViewDelegate
-(void)JZOnBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
