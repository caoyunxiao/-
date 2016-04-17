//
//  AppDelegate.h
//  CosFund
//
//  Created by vivian on 15/9/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworkReachabilityManager.h"            //监控网络状态
#import "MyTabbarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSTimer *_myTimer;
    int _adTime;
    
    UILabel *_adLabel;
    
    NSString *_cover;
    NSString *_resideTime;
    NSString *_title;
    NSString *_uRL;
}
@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) TCMainTabBarController *mainTabVc;

@property (nonatomic, assign) AFNetworkReachabilityStatus netWorkStatus;    //网络状态
@property (nonatomic,strong) MyTabbarViewController *Mytabbar;

/**
 *  是否全屏
 */
@property(nonatomic, assign) BOOL isFullScreen;


- (void)LGIndexViewController;


@end

