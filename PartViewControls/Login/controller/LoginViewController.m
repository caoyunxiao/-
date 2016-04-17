//
//  LoginViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/28.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
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
    
    self.title = @"登录";
    
    self.phoneView.layer.borderWidth = 1.0;
    self.phoneView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.phoneView.layer.masksToBounds = YES;
    self.phoneView.layer.cornerRadius = 1;
    
    self.passWordView.layer.borderWidth = 1.0;
    self.passWordView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.passWordView.layer.masksToBounds = YES;
    self.passWordView.layer.cornerRadius = 1;
    
    
    //获取登陆的用户名和密码
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]!=nil&&[[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"]!=nil) {
        
        self.phoneText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        self.passWordText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    }
}
#pragma mark - 忘记密码
- (IBAction)forgetBtnClick:(UIButton *)sender {
    ForgetPasswordViewController *fvc = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
}

#pragma mark - 登录
- (IBAction)LogInBtn:(UIButton *)sender
{
    if(self.phoneText.text.length<=0)
    {
        Alert(@"请输入你的账号");
        return;
    }
    if(self.passWordText.text.length<=0)
    {
        Alert(@"请输入密码");
        return;
    }
    
    NSString *passWord = [self collegePasswordEncryptionAlgorithm:self.passWordText.text];
    
    //登录类型1 qq \2 wechat \3 sina \4 默认方式
    //NSDictionary *wParamDict = @{@"userid":self.phoneText.text,@"pwd":passWord,@"type":@"4"};
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneText.text,@"userid",passWord,@"pwd",@"4",@"type", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"100" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode ]);
        if([errorCode isEqualToString:@"0"])
        {
            
            NSDictionary *dict = [(NSArray *)resultDict firstObject];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.phoneText.text forKey:@"userName"];
            [defaults setObject:self.passWordText.text forKey:@"passWord"];
            [defaults setObject:@"4" forKey:KLogInType];
            [defaults synchronize];
            [PersonInfo sharePersonInfo].userName = self.phoneText.text;
            [PersonInfo sharePersonInfo].passWord = self.passWordText.text;
            [PersonInfo sharePersonInfo].isLogIn = YES;
            [PersonInfo sharePersonInfo].age = [NSString stringWithFormat:@"%@",dict[@"age"]];
            [PersonInfo sharePersonInfo].describe = dict[@"describe"];
            [PersonInfo sharePersonInfo].gender = [NSString stringWithFormat:@"%@",dict[@"gender"]];
            [PersonInfo sharePersonInfo].headImg = dict[@"headImg"];
            [PersonInfo sharePersonInfo].nickname = dict[@"nickname"];
            [PersonInfo sharePersonInfo].userId = [NSString stringWithFormat:@"%@",dict[@"userId"]];
            [PersonInfo sharePersonInfo].email = dict[@"email"];
            /*ergegergergergerg*/
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
            //登录成功
            [self dismissViewControllerAnimated:YES completion:nil];
        }
//        else if ([errorCode isEqualToString:@"1203"])
//        {
//            Alert(@"账户不存在");
//        }
//        else if ([errorCode isEqualToString:@"1202"])
//            
//        {
//            Alert(@"密码有误");
//        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"登录失败,请检查您的账号和密码!");
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*呵呵急急急急急急一体化融合和急急急*/
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */






@end
