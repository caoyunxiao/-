//
//  BaseViewController.m
//  CosFund
//
//  Created by vivian on 15/9/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "MobClick.h"
#import "UMSocial.h"

#import "LGIndexViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TwoShoppingCartController.h"                  //购物车试图控制器
@interface BaseViewController ()<UMSocialUIDelegate,UIGestureRecognizerDelegate>
{
    UIView *_navView;
    UIView *_loadIngView;
}


@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self uiConfig];
  
    [self.navigationItem setHidesBackButton:YES];
    
}

- (void)uiConfig
{
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
}
#pragma mark - 重写getter方法
- (UIView *)loadingFailureView
{
    CGFloat widthNew = 100;
    if (_loadingFailureView == nil) {
       _loadingFailureView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-widthNew)/2, (ScreenHeight-widthNew)/2-64, widthNew, widthNew+30)];
        _loadingFailureView.hidden = NO;
        [self.view addSubview:_loadingFailureView];
        [_loadingFailureView bringSubviewToFront:self.view];
        _loadingFailureView.userInteractionEnabled = NO;
        
        _loadingFailureView.alpha = 1;
        
        UIImageView *pathViewFailure = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthNew, widthNew)];
        pathViewFailure.image = [UIImage imageNamed:@"loadFailed"];
        
        [_loadingFailureView addSubview:pathViewFailure];
        tiShiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, widthNew, widthNew, 30)];
        tiShiLabel.textColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1.0];
        tiShiLabel.font = [UIFont systemFontOfSize:12];
        tiShiLabel.numberOfLines = 0;
        tiShiLabel.textAlignment = NSTextAlignmentCenter;
        [_loadingFailureView addSubview:tiShiLabel];
    }
    return _loadingFailureView;
    
}
#pragma mark - 创建返回按钮
- (void)setBackButtonWithisPush:(BOOL)isPush AndViewcontroll:(UIViewController *)Viewself
{
    [[NSNotificationCenter defaultCenter] removeObserver:Viewself];
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"TCBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    if(isPush)
    {
        [backBtn addTarget:self action:@selector(backBtnPush) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
}
#pragma mark - 设置购物车
- (void)setShopRightButton
{
    _carBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    //购物车
    [_carBtn addTarget:self action:@selector(carBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_carBtn setImage:[UIImage imageNamed:@"Shop_car"] forState:UIControlStateNormal];
    UIBarButtonItem *carItem = [[UIBarButtonItem alloc]initWithCustomView:_carBtn];
    self.navigationItem.rightBarButtonItem = carItem;
}

#pragma mark - 购物车方法
- (void)carBtnClick
{
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    //父类 购物车方法
    TwoShoppingCartController *twoVc = [[TwoShoppingCartController alloc] init];
    
    twoVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:twoVc animated:YES];
    
}

- (void)backBtnPush
{
    [PersonInfo sharePersonInfo].photoCount = 0;
    [self.navigationController popViewControllerAnimated:YES];
    /*阿尔噶尔个人各位人格侮辱噶尔gear高*/
}

- (void)backBtnPress
{
    [PersonInfo sharePersonInfo].photoCount = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 创建等待视图
- (void)createLoadingView
{
    _loadIngView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_loadIngView];
    [_loadIngView bringSubviewToFront:self.view];
    _loadIngView.backgroundColor = [UIColor clearColor];
    _loadIngView.alpha = 1;
    
    CGFloat width = 150;
    
    GifView *pathView =[[GifView alloc] initWithFrame:CGRectMake((ScreenWidth-width)/2, (ScreenHeight-64-44-width)/2, width, width) filePath:[[NSBundle mainBundle] pathForResource:@"loadImageNew" ofType:@"gif"]];
    [_loadIngView addSubview:pathView];
    
}


//渐隐提示框
- (void)SHOWPrompttext:(NSString *)Text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = Text;
    hud.margin = 10.f;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0f];
    
}

//判断相机权限是否开启
- (BOOL)Determinethecamerapermissions
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        NSLog(@"相机权限受限");
        return NO;
    }
    else
    {
        return YES;
    }
}


//判断相册权限是否开启
- (BOOL)Judgealbumpermissions
{
    AVAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == AVAuthorizationStatusRestricted || author ==AVAuthorizationStatusDenied){
        //无权限
        return NO;
        
    }

    return YES;

}

//显示等待视图
- (void)showLoadingViewZFJ
{
    [self createLoadingView];
}

#pragma mark - 点击隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//移除等待视图
- (void)removeLoadingViewZFJ
{
    [UIView animateWithDuration:0.3 animations:^{
        _loadIngView.alpha = 0;
        _loadIngView.hidden = YES;
    } completion:^(BOOL finished) {
        [_loadIngView removeFromSuperview];
    }];
    
}
//显示加载失败
- (void)showLoadingFailureViewZFJ:(NSString *)textLabel
{

    self.loadingFailureView.alpha = 1.0;
    self.loadingFailureView.hidden = NO;
    if(textLabel.length!=0)
    {
        tiShiLabel.text = textLabel;
    }
    
}
//移除加载失败
- (void)removeLoadingFailureViewZFJ
{
    [UIView animateWithDuration:0.3 animations:^{
        _loadingFailureView.alpha = 0;
    } completion:^(BOOL finished) {
        _loadingFailureView.hidden = YES;
        [_loadingFailureView removeFromSuperview];
    }];

}

#pragma mark - 隐藏多余的cell分界面
- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
}

//密码加密算法
- (NSString *)collegePasswordEncryptionAlgorithm:(NSString *)passWord
{
    NSString *strCode = [NSString stringWithFormat:@"%@%@",passWord,KEncryptionCode];
    return [strCode stringFromMD5];
}
#pragma mark - 获取时间戳
+ (NSString *)getTheTimestamp
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}

#pragma mark - 把时间戳格式化输出
+ (NSString *)getTimerStrFromTimestamp:(NSString *)timeString
{
   
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeString integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
   
    
}
#pragma mark - 将服务器时间转化成字符串
+ (NSString *)getTimerStrFromSever:(NSString *)SeverTime
{

    return SeverTime;
}


#pragma mark -一个时间距离现在的时间
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    
   theDate = [theDate stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=late-now;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天", timeString];
        
    }
    return timeString;
}


#pragma mark - 通过字典获取wParam
+ (NSString *)getwParamFromDict:(NSDictionary *)dict
{
    NSArray *keyArray = [dict allKeys];
    NSArray *objArray = [dict allValues];
    NSMutableString *resultStr = [[NSMutableString alloc]init];
    for(int i = 0;i<[dict count];i++)
    {
        NSString *str = nil;
        if(i != dict.count-1)
        {
            str = [NSString stringWithFormat:@"%@=%@_",[keyArray objectAtQYQIndex:i],[objArray objectAtQYQIndex:i]];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@=%@",[keyArray objectAtQYQIndex:i],[objArray objectAtQYQIndex:i]];
        }
        [resultStr appendString:str];
    }
    return resultStr;
}
#pragma mark - 通过字典获取bodyString
+ (NSString *)getBodyStringFromDict:(NSDictionary *)dict
{
    NSArray *keyArray = [dict allKeys];
    NSArray *objArray = [dict allValues];
    NSMutableString *resultStr = [[NSMutableString alloc]init];
    for(int i = 0;i<[dict count];i++)
    {
        NSString *str = nil;
        if(i != dict.count-1)
        {
            str = [NSString stringWithFormat:@"%@=%@&",[keyArray objectAtQYQIndex:i],[objArray objectAtQYQIndex:i]];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@=%@",[keyArray objectAtQYQIndex:i],[objArray objectAtQYQIndex:i]];
        }
        [resultStr appendString:str];
    }
    return resultStr;
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 分享到各个平台

- (void)shareWith:(NSString *)text image:(UIImage *)image
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:kUmengAppkey shareText:text shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToWechatTimeline,nil] delegate:self];
}
- (void)shareWithTitle:(NSString *)title describe:(NSString *)describe image:(UIImage *)image imageURL:(NSString *)imageURL video:(NSString *)videoURL  returnURL:(NSString *)returnURL;
{
    
    if (imageURL) {
        
       // [UMSocialData defaultData].
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageURL];
    }
    
    if (videoURL) {
        
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:videoURL];
    }
    
    //微信内容
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = returnURL;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = returnURL;
     [UMSocialData defaultData].extConfig.qqData.url = returnURL;
    [UMSocialData defaultData].extConfig.qqData.title = title;
     [UMSocialData defaultData].extConfig.qzoneData.url = returnURL;
    
   
    [UMSocialSnsService presentSnsIconSheetView:self appKey:kUmengAppkey shareText:describe shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToWechatTimeline,nil] delegate:self];
    
    
    
}
//分享之后的回调方法
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        
        Alert(@"分享成功");
    }
}

#pragma mark - 添加友盟统计的方法
- (void)viewWillAppear:(BOOL)animated
{
    
    if (self.title) {
        [super viewWillAppear:animated];
        [MobClick beginLogPageView:self.title];
        
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    if (self.title) {
        [super viewWillDisappear:animated];
        [MobClick endLogPageView:self.title];
    }
}

//提示登录的信息
- (void)showLogInViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有登录呢,快点去登录吧!" delegate:self cancelButtonTitle:@"再看看" otherButtonTitles:@"去登录", nil];
    alert.tag = 30;
    [alert show];
}

+ (void)showLogInViewControllerTwo
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有登录呢,快点去登录吧!" delegate:self cancelButtonTitle:@"再看看" otherButtonTitles:@"去登录", nil];
    alert.tag = 30;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 30)
    {
        if(buttonIndex==0)
        {
            //再看看
        }
        else if (buttonIndex==1)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //去登录
                LGIndexViewController *lvc = [[LGIndexViewController alloc]init];
                lvc.isPresent = YES;
                UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
                
                nvc.interactivePopGestureRecognizer.delegate = self;
                
                [self.navigationController presentViewController:nvc animated:YES completion:nil];
               
            });
           
            
        }
    }
}
//获取OSS的ObjectKey
+ (NSString *)getOSSObjectKey
{
    NSMutableString *ObjectKey = [[NSMutableString alloc]init];
    NSString *userName = [PersonInfo sharePersonInfo].userName;
    if(userName!=nil && userName.length>0)
    {
        [ObjectKey appendString:userName];
    }
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    if(timeString!=nil && timeString.length>0)
    {
        [ObjectKey appendString:timeString];
    }
    if(ObjectKey.length<=userName.length||ObjectKey.length<=timeString.length)
    {
        return nil;
    }
    else
    {
        return ObjectKey;
    }
}

//获取OSS的ObjectKey
+ (NSString *)getOSSObjectKey:(NSInteger)index
{
    NSMutableString *ObjectKey = [[NSMutableString alloc]init];
    NSString *userName = [PersonInfo sharePersonInfo].userName;
    if(userName!=nil && userName.length>0)
    {
        [ObjectKey appendString:userName];
    }
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a+index]; //转为字符型
    if(timeString!=nil && timeString.length>0)
    {
        [ObjectKey appendString:timeString];
    }
    if(ObjectKey.length<=userName.length||ObjectKey.length<=timeString.length)
    {
        return nil;
    }
    else
    {
        return ObjectKey;
    }
}

//获取上传到OSSkey
- (NSString *)getOSSObjectKeyWithtype:(NSString *)type
{
    NSString *osskey = [BaseViewController getOSSObjectKey];
   
    NSString *urlString = [NSString stringWithFormat:@"%@.%@",osskey,type];
    
    return urlString;
}

- (NSString *)getOSSObjectKeyWithtype:(NSString *)type index:(NSInteger)index
{
    NSString *osskey = [BaseViewController getOSSObjectKey:index];
    
    NSString *urlString = [NSString stringWithFormat:@"%@.%@",osskey,type];
    
    return urlString;
}

- (NSString *)getImageUrlWithKey:(NSString *)oSSObjectKey
{
    return [NSString stringWithFormat:@"http://image.cosfund.com/%@",oSSObjectKey];
}
- (NSString *)getVideoUrlWithKey:(NSString *)oSSObjectKey
{
    return [NSString stringWithFormat:@"http://video.cosfund.com/%@",oSSObjectKey];
}

+ (NSString *)getOSSObjectKeyWithtype:(NSString *)type
{
    NSString *osskey = [BaseViewController getOSSObjectKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@.%@",osskey,type];
    
    return urlString;
}

+ (NSString *)getOSSObjectKeyWithtype:(NSString *)type index:(NSInteger)index
{
    NSString *osskey = [BaseViewController getOSSObjectKey:index];
    
    NSString *urlString = [NSString stringWithFormat:@"%@.%@",osskey,type];
    
    return urlString;
}

+ (NSString *)getImageUrlWithKey:(NSString *)oSSObjectKey
{
    return [NSString stringWithFormat:@"http://image.cosfund.com/%@",oSSObjectKey];
}
+ (NSString *)getVideoUrlWithKey:(NSString *)oSSObjectKey
{
    return [NSString stringWithFormat:@"http://video.cosfund.com/%@",oSSObjectKey];
}



@end
