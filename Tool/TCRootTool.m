//
//  TCRootTool.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/15.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TCRootTool.h"
#import "IndexViewController.h"     //引导页面

#define TCVersionKey @"version"
@implementation TCRootTool


// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    
//    //获取当前的版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    //获取上一次的版本号
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:TCVersionKey];
//   

    // v1.0
    // 判断当前是否有新的版本
   // if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
        
        // 创建tabBarVc
//        IWTabBarController *tabBarVc = [[IWTabBarController alloc] init];
        MyTabbarViewController *tabBarVc = [[MyTabbarViewController alloc]init];
        SHARED_APPDELEGATE.Mytabbar = tabBarVc;
    
    
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
        
        
//    }else{ // 有最新的版本号
//        
//        // 进入新特性界面
//        // 如果有新特性，进入新特性界面
//        IndexViewController *vc = [[IndexViewController alloc] init];
//        
//        window.rootViewController = vc;
//        
//        // 保持当前的版本，用偏好设置
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:TCVersionKey];
//    }
}

@end
