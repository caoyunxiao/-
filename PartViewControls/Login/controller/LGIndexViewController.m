//
//  LGIndexViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "LGIndexViewController.h"
#import "CPKenburnsView.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "UMSocial.h"
#import "PersonalFileViewController.h"
#import "MyButton.h"
#import "PriviteViewController.h"
@interface LGIndexViewController ()

@end

@implementation LGIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiConfig];
}

- (void)uiConfig
{
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    if(self.isPresent == YES)
    {
        [self setBackButtonWithisPush:NO AndViewcontroll:self];
    }
    
    self.title = @"登入";
    
    self.LogInBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.registeredBtn.layer.borderWidth = 1.0;
    self.registeredBtn.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.registeredBtn.layer.masksToBounds = YES;
    self.registeredBtn.layer.cornerRadius = 5;
    
    CPKenburnsView *kenbunrsView = [[CPKenburnsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    kenbunrsView.image = [UIImage imageNamed:@"1.jpg"];
    [self.imageView addSubview:kenbunrsView];
    [self setTopViewToimageView];
}

#pragma mark - 设置覆盖物
- (void)setTopViewToimageView
{
    for(int i = 0;i < 70;i++)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 2*i, ScreenWidth, 2)];
        view.backgroundColor = [UIColor whiteColor];
        CGFloat alpha = (69-i)/69.0;
        view.alpha = alpha;
        [self.imageView addSubview:view];
    }
}

#pragma mark - 注册
- (IBAction)registeredBtnClick:(UIButton *)sender
{
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
#warning 注册类型
    rvc.typeStr = @"4";
    [self.navigationController pushViewController:rvc animated:YES];
}

#pragma mark - qq登陆
- (IBAction)QQClick:(UIButton *)sender {
    
    ////登录类型1 qq \2 wechat \3 sina \4 默认方式
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [self LogInRequestWithOpid:snsAccount type:@"1"];
            
        }});
    
}
#pragma mark - 微信登陆
- (IBAction)WEIXINClick:(UIButton *)sender {
    
    ////登录类型1 qq \2 wechat \3 sina \4 默认方式
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccountNew = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccountNew.userName,snsAccountNew.usid,snsAccountNew.accessToken,snsAccountNew.iconURL);
            
            [self LogInRequestWithOpid:snsAccountNew type:@"2"];
            
        }
    });
}
#pragma mark - 登录
- (IBAction)LogInBtnClick:(UIButton *)sender {
    
    LoginViewController *lvc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:lvc animated:YES];
}

#pragma mark - 第三方登录注册接口
- (void)LogInRequestWithOpid:(UMSocialAccountEntity *)snsAccount type:(NSString *)type
{
    //登录类型1 qq \2 wechat \3 sina \4 默认方式
    //NSDictionary *wParamDict = @{@"userid":snsAccount.usid,@"pwd":@"0",@"type":type};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:snsAccount.usid,@"userid",@"0",@"pwd",type,@"type" , nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"100" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            NSLog(@"第三方登录注册接口%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            NSDictionary *dict = [array firstObject];
            [self keepValueInNSUserDefaults:snsAccount type:type];
            [PersonInfo sharePersonInfo].userName = snsAccount.usid;
            [PersonInfo sharePersonInfo].passWord = @"";
            [PersonInfo sharePersonInfo].isLogIn = YES;
            [PersonInfo sharePersonInfo].age = [dict[@"age"] description];
            [PersonInfo sharePersonInfo].describe = [dict[@"describe"] description];
            [PersonInfo sharePersonInfo].gender = [dict[@"gender"] description];
            [PersonInfo sharePersonInfo].headImg = [dict[@"headImg"] description];
            [PersonInfo sharePersonInfo].nickname = [dict[@"nickname"] description];
            [PersonInfo sharePersonInfo].userId = [dict[@"userId"] description];
            [PersonInfo sharePersonInfo].email = [dict[@"email"] description];
            //发送登陆成功的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            [UIView animateWithDuration:0.3 animations:^{self.view.alpha = 0.5;} completion:^(BOOL finished)
             {
                 ;
//                 [SHARED_APPDELEGATE IWTabBarController];
//                 for (UIView *view in SHARED_APPDELEGATE.Mytabbar.imageview.subviews) {
//                     
//                     if ([view isKindOfClass:[MyButton class]]) {
//                         
//                         MyButton *button = (MyButton *)view;
//                         button.selected = NO;
//                     }
//                 }
//                 SHARED_APPDELEGATE.Mytabbar.selectedIndex = 4;
//                 MyButton *button = [SHARED_APPDELEGATE.Mytabbar.imageview.subviews objectAtIndex:4];
//                 button.selected = YES;
                 
             }];
        }
        else if([errorCode isEqualToString:@"1203"])
        {
            [self keepValueInNSUserDefaults:snsAccount type:type];
            RegisterViewController *pvc = [[RegisterViewController alloc]init];
            pvc.snsAccount = snsAccount;
            pvc.typeStr = type;
            [self.navigationController pushViewController:pvc animated:YES];
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"登录失败");
        }
    }];
}

- (void)keepValueInNSUserDefaults:(UMSocialAccountEntity *)snsAccount type:(NSString *)type
{
    if(snsAccount!=nil)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];//KLogInType
        [defaults setObject:type forKey:KLogInType];
        [defaults setObject:snsAccount.accessToken forKey:KaccessToken];
        [defaults setObject:snsAccount.expirationDate forKey:KexpirationDate];
        [defaults setObject:snsAccount.iconURL forKey:KiconURL];
        [defaults setObject:snsAccount.platformName forKey:KplatformName];
        [defaults setObject:snsAccount.profileURL forKey:KprofileURL];
        [defaults setObject:snsAccount.userName forKey:KuserName];
        [defaults setObject:snsAccount.usid forKey:Kusid];
        [defaults synchronize];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
/*不让他还不如问题和侮辱他不会*/





- (IBAction)priviteClick:(UIButton *)sender {
    
    PriviteViewController *pvc = [[PriviteViewController alloc] init];
    
    [self.navigationController pushViewController:pvc animated:YES];
    
}
@end
