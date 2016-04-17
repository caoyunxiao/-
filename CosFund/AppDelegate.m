//
//  AppDelegate.m
//  CosFund
//
//  Created by vivian on 15/9/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "AppDelegate.h"
#import "LGIndexViewController.h"
//#import "IWTabBarController.h"
#import "IndexViewController.h"       //引导页
#import "MobClick.h"                  //友盟统计
#import "UMSocial.h"                  //友盟分享
#import "UMSocialWechatHandler.h"     //友盟微信分享
#import "UMSocialSinaHandler.h"       //友盟新浪分享
#import "UMSocialQQHandler.h"         //友盟QQ分享
#import <AlipaySDK/AlipaySDK.h>       //支付宝
#import "GBWXPayManager.h"            //微信支付
#define TCVersionKey @"version"
#import "SCNavigationController.h"
#import <TAESDK/TAESDK.h>
#import <Bugly/CrashReporter.h>
#import "UIImageView+WebCache.h"

#import "AdViewController.h"          //广告启动页面
@interface AppDelegate ()<WXApiDelegate,UITabBarControllerDelegate>

{
    MyTabbarViewController *mainVc;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

        [[TaeSDK sharedInstance] asyncInit:^{
            
            
            
        } failedCallback:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
    
    //启动广告页面

    
    //微信支付注册
    [self registerWeixin];
    [self setUINavigationBar];
    [self LGIndexViewController];

    //IOS9.0以上支持
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        
        //3DTouch
        [self ThreeDtouch];
    }

    [self setUpUmsocialAndAnalytics];
    // 创建窗口
    [self judgeLogIn];
    
   
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    //获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:TCVersionKey];
    //判断是否有新的版本
    if ([currentVersion isEqualToString:lastVersion])
    {
        AdViewController *adVc = [[AdViewController alloc] init];
        
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:adVc];
        
        self.window.rootViewController = navc;
    }
    else
    {
        //进入引导页
        IndexViewController *indexController = [[IndexViewController alloc] init];
        self.window.rootViewController = indexController;
        
        //保存当前的版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:TCVersionKey];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }

  
    // 显示窗口
    [self.window makeKeyAndVisible];
    //监控网络状态
    [self monitorNetWorkStatus];
    //清空抢注的handler
    NSSetUncaughtExceptionHandler(NULL);
    [[CrashReporter sharedInstance] enableLog:YES];
    //Debug//检测卡顿
    [[CrashReporter sharedInstance] enableBlockMonitor:YES];
    //Bugly初始化
    [[CrashReporter sharedInstance] installWithAppId:@"900014124"];
    //    [self performSelector:@selector(creah) withObject:nil afterDelay:3.0f];
    
    
    
     return YES;
}


#pragma mark 3DTouch
- (void)ThreeDtouch
{
    UIApplicationShortcutIcon *icom_1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_camera"];
    UIApplicationShortcutItem *quickItem_1 = [[UIApplicationShortcutItem alloc] initWithType:@"0" localizedTitle:@"发布梦想" localizedSubtitle:nil icon:icom_1 userInfo:nil];
    UIApplicationShortcutIcon *icom_2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_film"];
    UIApplicationShortcutItem *quickItem_2 = [[UIApplicationShortcutItem alloc] initWithType:@"1" localizedTitle:@"福利社" localizedSubtitle:nil icon:icom_2 userInfo:nil];
    [[UIApplication sharedApplication] setShortcutItems:@[quickItem_1,quickItem_2]];
}


#pragma mark -3DTouch回调
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{

    if ([shortcutItem.type isEqualToString:@"0"]) {


        for (UIButton *Button in mainVc.imageview.subviews) {
            
            Button.selected = NO;
        }
        UIButton *showbutton = [mainVc.imageview.subviews objectAtQYQIndex:2];
        showbutton.selected = YES;
        mainVc.selectedIndex = 2;
   
        
    }else if ([shortcutItem.type isEqualToString:@"1"])
    {

        for (UIButton *Button in mainVc.imageview.subviews) {
            
            Button.selected = NO;
        }
        UIButton *showbutton = [mainVc.imageview.subviews objectAtQYQIndex:3];
        showbutton.selected = YES;
        
        mainVc.selectedIndex = 3;
    }
}

#pragma mark - 自动登录
- (void)judgeLogIn
{
    BaseViewController *bvc = [[BaseViewController alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *LogInType = [defaults objectForKey:KLogInType];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    
    NSString *passWord = [defaults objectForKey:@"passWord"];
    
    NSString *passWordMD5 = [bvc collegePasswordEncryptionAlgorithm:passWord];
    
    if([LogInType isEqualToString:@"1"]||[LogInType isEqualToString:@"2"]||[LogInType isEqualToString:@"3"])
    {
        NSString *usid = [defaults objectForKey:Kusid];
        //登录类型1 qq \2 wechat \3 sina \4 默认方式
        if(usid!=nil)
        {
            NSDictionary *wParamDict = @{@"userid":usid,@"pwd":@"",@"type":LogInType};
            [self logInRequestWith:wParamDict userName:userName passWord:passWord];
        }
        
        else
        {
            [PersonInfo sharePersonInfo].isLogIn = NO;
        }
        
    }
    else if([LogInType isEqualToString:@"4"])
    {
        if(userName!=nil && passWord!=nil)
        {
            //登录类型1 qq \2 wechat \3 sina \4 默认方式
            NSDictionary *wParamDict = @{@"userid":userName,@"pwd":passWordMD5,@"type":@"4"};
            [self logInRequestWith:wParamDict userName:userName passWord:passWord];
        }
        else
        {
            [PersonInfo sharePersonInfo].isLogIn = NO;
        }
    }
    else
    {
        [PersonInfo sharePersonInfo].isLogIn = NO;
    }
}

#pragma mark - 登录请求函数
- (void)logInRequestWith:(NSDictionary *)wParamDict userName:(NSString *)userName passWord:(NSString *)passWord
{
    NSDictionary *dictResult = [RequestEngine requestDataWithWParamDict:wParamDict wAction:@"100"];
    NSArray *resultArr = (NSArray *)dictResult;
    NSDictionary *resultDict = [resultArr firstObject];
    if(resultDict!=nil)
    {
        [PersonInfo sharePersonInfo].isLogIn = YES;
        [PersonInfo sharePersonInfo].userName = userName;
        [PersonInfo sharePersonInfo].passWord = passWord;
        [PersonInfo sharePersonInfo].age = [NSString stringWithFormat:@"%@",resultDict[@"age"]];
        [PersonInfo sharePersonInfo].describe = resultDict[@"describe"];
        [PersonInfo sharePersonInfo].gender = [NSString stringWithFormat:@"%@",resultDict[@"gender"]];
        [PersonInfo sharePersonInfo].headImg = resultDict[@"headImg"];
        [PersonInfo sharePersonInfo].nickname = resultDict[@"nickname"];
        [PersonInfo sharePersonInfo].userId = [NSString stringWithFormat:@"%@",resultDict[@"userId"]];
        [PersonInfo sharePersonInfo].email = resultDict[@"email"];
    }
    else
    {
        [PersonInfo sharePersonInfo].isLogIn = NO;
    }
}



- (void)LGIndexViewController
{
    LGIndexViewController *lvc = [[LGIndexViewController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
    
    self.window.rootViewController = nvc;
}

- (void)setUINavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:kColor(216, 0, 104)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
#pragma mark - 向微信注册
- (void)registerWeixin
{
    [WXApi registerApp:APP_ID withDescription:nil];
}
#pragma mark - 设置友盟相关信息
- (void)setUpUmsocialAndAnalytics
{
    
    [MobClick startWithAppkey:kUmengAppkey reportPolicy:BATCH channelId:nil];//设置友盟统计
    
    [UMSocialData setAppKey:kUmengAppkey];
    
    //对未安装客服端应用的用户进行隐藏
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    [UMSocialWechatHandler setWXAppId:kWXAppId appSecret:kWXAppSecret url:nil];
    
    [UMSocialQQHandler setQQWithAppId:KQQAppID appKey:KQQAppKEY url:@"http://www.cosfund.com"];
    
}
#pragma mark - 微信分享的回调方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - 从各个应用跳回来的方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
       // NSLog(@"%@",resultDic);
        
       // NSLog(@"result = %@",resultDic[@"result"]);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayResult" object:[resultDic objectForKey:@"resultStatus"]];
    }];
        return YES;
        
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
           // NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
    
    if ([url.host isEqualToString:@"pay"]) { //微信支付
        
        return  [WXApi handleOpenURL:url delegate:self];
        
    }
    
    //友盟
    return  [UMSocialSnsService handleOpenURL:url];

}

#pragma mark - 微信支付回调
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle = nil;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayresult" object:@"1"];
                
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayresult" object:@"0"];
                
                
                break;
        }
        
    }
   // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alert show];
}

#pragma mark - 使用第三方登陆需要重写下面两个方法
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //登陆需要编写
    [UMSocialSnsService applicationDidBecomeActive];
}
#pragma mark - 监控网络状态
- (void)monitorNetWorkStatus{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                self.netWorkStatus = AFNetworkReachabilityStatusNotReachable;
                NSLog(@"网络异常，请检查网络设置！");
                
                //ShowMessage(@"网络异常，请检查网络设置！");
                Alert(@"网络异常，请检查网络设置");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                self.netWorkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                self.netWorkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                NSLog(@"WIFI");
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring
    
     ];
}


#pragma mark - 接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}   

- (NSInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isFullScreen) {
        return UIInterfaceOrientationMaskAll;
        return UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationMaskPortrait;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

@end
