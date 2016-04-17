//
//  ForgetPasswordViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/28.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SetNewViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad
{
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
    
    self.title = @"找回密码";
    
    _sentTimers = 0;
    
    self.phoneView.layer.borderWidth = 1.0;
    self.phoneView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.phoneView.layer.masksToBounds = YES;
    self.phoneView.layer.cornerRadius = 1;
    
    self.VerificationView.layer.borderWidth = 1.0;
    self.VerificationView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.VerificationView.layer.masksToBounds = YES;
    self.VerificationView.layer.cornerRadius = 1;
}

#pragma mark - 判断验证码是否正确
- (void)verificationCode
{
    //NSDictionary *wParamDict = @{@"mobile":self.phoneText.text};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneText.text,@"mobile", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"1100" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        _sentTimers ++;
        if([errorCode isEqualToString:@"0"])
        {
            [self startTimer];
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"验证码发送失败");
        }
    }];

}
//找回密码
- (IBAction)findPassWordClick:(UIButton *)sender
{
    if (![HENLENSONG isValidateMobile:self.phoneText.text])
    {
        Alert(@"请输入正确的手机号码");
        return;
    }

    if (self.VerificationText.text.length!=4)
    {
        Alert(@"请输入正确的验证码");
        return;
    }
    //NSDictionary *wParamDict = @{@"mobile":self.phoneText.text,@"code":self.VerificationText.text};
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneText.text,@"mobile",self.VerificationText.text,@"code", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"1101" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        _sentTimers ++;
        if([errorCode isEqualToString:@"0"])
        {
            SetNewViewController *svc = [[SetNewViewController alloc]init];
            svc.verificationStr = self.VerificationText.text;
            svc.userid = self.phoneText.text;
            [self.navigationController pushViewController:svc animated:YES];
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"验证码有误");
        }
    }];

    
}
#pragma mark - 找回密码的数据请求

//获取验证码
- (IBAction)getVerificationClick:(UIButton *)sender
{
    
    if(_sentTimers<3)
    {
        if (![HENLENSONG isValidateMobile:self.phoneText.text])
        {
            Alert(@"请输入正确的手机号码");
            return;
        }
        
       // NSDictionary *wParamDictChare =@{@"userid":self.phoneText.text};
        
         NSDictionary *wParamDictChare = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneText.text,@"userid", nil];
        
        NSDictionary *responseObject = (NSDictionary *)[RequestEngine getrequestDataWithWParamDict:wParamDictChare wAction:@"103"];
        if(responseObject!=nil)
        {
            NSString * returnCodeStr = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"ReturnCode"]];
            
            NSInteger hasRes = [returnCodeStr integerValue];
            
            if(hasRes==1203)
            {
                Alert(@"手机号码不存在");
                return;
            }
            
            //NSDictionary *wParamDict = @{@"mobile":self.phoneText.text};
             NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneText.text,@"mobile", nil];
            [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"1100" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                _sentTimers ++;
                if([errorCode isEqualToString:@"0"])
                {
                    sender.userInteractionEnabled = NO;
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
    else
    {
        Alert(@"你获取验证码过于频繁，请稍后再试");
    }
}
#pragma mark - 定时器
- (void)startTimer
{
    _iTimer = 89;
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];
}
#pragma mark - 定时器事件
- (void)myTimer
{
    NSString *string = [NSString stringWithFormat:@"重新获取(%ds)",_iTimer];
    self.getVerificationLabel.text = string;
    if (_iTimer == 0)
    {
        _getVerification.userInteractionEnabled = YES;
        self.getVerificationLabel.text = @"重新获取";
        [_myTimer invalidate];
        _myTimer = nil;
    }
    _iTimer--;
  

  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    /*额vqewrververververververver*/
}
/*改变vebvetbvetbe他还不分vefveververvrv分vefvev而v如他不让他还不如天河北那天有那天你讨厌那他们呢tbetbetb*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
















@end
