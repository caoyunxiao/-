//
//  RegisterViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/28.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "RegisterViewController.h"
#import "PersonalFileViewController.h"
#import "RegisterSuccessViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self uiConfig];
    [self useSnsAccountForUIValue];
    
}

- (void)uiConfig
{
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    self.title = @"注册";
    
    self.phoneView.layer.borderWidth = 1.0;
    self.phoneView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.phoneView.layer.masksToBounds = YES;
    self.phoneView.layer.cornerRadius = 1;
    
    self.VerificationView.layer.borderWidth = 1.0;
    self.VerificationView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.VerificationView.layer.masksToBounds = YES;
    self.VerificationView.layer.cornerRadius = 1;
    
    self.getVerification.layer.borderWidth = 1.0;
    self.getVerification.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.getVerification.layer.masksToBounds = YES;
    self.getVerification.layer.cornerRadius = 1;
    
    self.InviteCodeView.layer.borderWidth = 1.0;
    self.InviteCodeView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.InviteCodeView.layer.masksToBounds = YES;
    self.InviteCodeView.layer.cornerRadius = 1;
    
    self.userNameView.layer.borderWidth = 1.0;
    self.userNameView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.userNameView.layer.masksToBounds = YES;
    self.userNameView.layer.cornerRadius = 1;
    
    self.passWordView.layer.borderWidth = 1.0;
    self.passWordView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.passWordView.layer.masksToBounds = YES;
    self.passWordView.layer.cornerRadius = 1;
    
    self.sureView.layer.borderWidth = 1.0;
    self.sureView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.sureView.layer.masksToBounds = YES;
    self.sureView.layer.cornerRadius = 1;
    
    self.getVerification.layer.borderWidth = 1.0;
    self.getVerification.layer.borderColor = [UIColor colorWithRed:210/255.0 green:0/255.0 blue:104/255.0 alpha:1].CGColor;
    self.getVerification.layer.masksToBounds = YES;
    self.getVerification.layer.cornerRadius = 1;
    
}

#pragma mark - 第三方登录赋值
- (void)useSnsAccountForUIValue
{
    if(self.snsAccount!=nil)
    {
        self.userNameText.text = self.snsAccount.userName;
    }
}


#pragma mark - 获取验证码
- (IBAction)getVerificationClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (![HENLENSONG isValidateMobile:self.phoneText.text])
    {
        Alert(@"请输入正确的手机号码");
        return;
    }
    
    //验证用户是否已注册
    NSDictionary *wParamDictChare =@{@"userid":self.phoneText.text};
    NSDictionary *responseObject = (NSDictionary *)[RequestEngine getrequestDataWithWParamDict:wParamDictChare wAction:@"103"];
    if(responseObject!=nil)
    {
        NSString * returnCodeStr = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"ReturnCode"]];
        
        NSInteger hasRes = [returnCodeStr integerValue];
        
        if(hasRes!=1203)
        {
            Alert(@"该手机号已经被注册过");
            return;
        }

        NSDictionary *wParamDict = @{@"mobile":self.phoneText.text};
        
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"1100" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            if([errorCode isEqualToString:@"0"])
            {
                self.getVerification.enabled = NO;
                [self startTimer];
            }
            else
            {
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
                Alert(@"验证码发送失败");
            }
        }];
    }
    else
    {
        Alert(@"数据错误");
        //验证失
//        self.getVerification.enabled = YES;
    }
}
#pragma mark - 定时器
- (void)startTimer
{
    _iTimer = 59;
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];
}
#pragma mark - 定时器事件
- (void)myTimer
{
    NSString *string = [NSString stringWithFormat:@"重新获取(%ds)",_iTimer];
    self.getVerificationLabel.text = string;
    if (_iTimer == 0)
    {
        self.getVerificationLabel.text = @"重新获取";
        self.getVerification.enabled = YES;
        [_myTimer invalidate];
        _myTimer = nil;
    }
    _iTimer--;
}

#pragma mark - 注册
- (IBAction)registered:(UIButton *)sender
{
    
//    RegisterSuccessViewController *registerview = [[RegisterSuccessViewController alloc]init];
//    [self.navigationController pushViewController:registerview animated:YES];
//    return;
    if (![HENLENSONG isValidateMobile:self.phoneText.text])
    {
        Alert(@"请输入正确的手机号码");
        return;
    }
    if(self.VerificationText.text.length==0)
    {
        Alert(@"请输入验证码");
        return;
    }
    if(self.userNameText.text.length==0)
    {
        Alert(@"请输入用户名");
        return;
    }
    if(self.passWord.text.length<6||self.passWord.text.length>15)
    {
        Alert(@"请输入6-12位密码");
        return;
    }
    if(![self.passWord.text isEqualToString:self.sureText.text])
    {
        Alert(@"验证密码有误");
        return;
    }

    NSString *passWord = [self collegePasswordEncryptionAlgorithm:self.passWord.text];
    
    NSString *usid = self.snsAccount.usid;
    
    if(self.typeStr==nil || self.typeStr.length == 0)
    {
        self.typeStr = @"4";
    }
    if(usid==nil || usid == 0)
    {
        usid = @"0";
    }
    
    NSString *invcode = self.InviteCodeText.text;
    if(invcode == nil || invcode == 0)
    {
        invcode = @" ";
    }
       
//    NSDictionary *wParamDict = @{@"mobile":self.phoneText.text,@"pwd":passWord,@"code":self.VerificationText.text,@"nickname":self.userNameText.text,@"invcode":invcode,@"from":@"10101",@"opid":usid,@"type":self.typeStr};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneText.text,@"mobile" ,passWord,@"pwd", self.VerificationText.text,@"code",self.userNameText.text,@"nickname",invcode,@"invcode", @"10101",@"from", usid,@"opid", self.typeStr,@"type", nil];
    
    self.getVerificationLabel.text = @"重新获取";
    self.getVerification.enabled = YES;
    [_myTimer invalidate];
    _myTimer = nil;
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"101" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            
            NSArray *array = (NSArray *)resultDict;
            NSDictionary *dict = [array lastObject];
             NSLog(@"注册返回的信息%@",dict);
            [PersonInfo sharePersonInfo].age = [NSString stringWithFormat:@"%@",dict[@"age"]];
            [PersonInfo sharePersonInfo].describe = [dict[@"describe"] isKindOfClass:[NSNull class]]?@"":dict[@"describe"];
            [PersonInfo sharePersonInfo].email = [dict[@"email"] isKindOfClass:[NSNull class]]?@"":dict[@"email"];
            [PersonInfo sharePersonInfo].gender = [dict[@"gender"] description];
            [PersonInfo sharePersonInfo].headImg = [dict[@"headImg"] isKindOfClass:[NSNull class]]?@"":dict[@"headImg"];
            [PersonInfo sharePersonInfo].nickname = dict[@"nickname"];
            [PersonInfo sharePersonInfo].userId = [NSString stringWithFormat:@"%@",dict[@"userId"]];
            [PersonInfo sharePersonInfo].userName = [NSString stringWithFormat:@"%@",dict[@"userName"]];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.phoneText.text forKey:@"userName"];
            [defaults setObject:self.passWord.text forKey:@"passWord"];
            [defaults setObject:@"4" forKey:KLogInType];
            [defaults synchronize];
            
            RegisterSuccessViewController *registerview = [[RegisterSuccessViewController alloc]init];
            [self.navigationController pushViewController:registerview animated:YES];
            
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"注册失败");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






@end
