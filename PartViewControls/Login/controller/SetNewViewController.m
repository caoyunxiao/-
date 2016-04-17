//
//  SetNewViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SetNewViewController.h"

#import "LoginViewController.h"        //登陆页面
@interface SetNewViewController ()<UIAlertViewDelegate>

@end

@implementation SetNewViewController

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
    
    self.title = @"设置密码";
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
}

#pragma mark - 找回密码
- (IBAction)sureSetBtn:(UIButton *)sender {
    
    if(self.passWord.text.length<6||self.passWord.text.length>15)
    {
        Alert(@"请输入6-15位密码");
        return;
    }
    
    NSString *pwd = [self collegePasswordEncryptionAlgorithm:self.passWord.text];
//    NSDictionary *wParamDict = @{@"mobile":self.userid,@"pwd":pwd,@"code":self.verificationStr};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.userid,@"mobile", pwd,@"pwd", self.verificationStr,@"code", nil];
    
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"104" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if([errorCode isEqualToString:@"0"])
        {
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"找回密码成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登陆", nil];
            
            [al show];
        }
//        else if ([errorCode isEqualToString:@"1203"])
//        {
//            Alert(@"账户不存在");
//        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        
        
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        
        
        
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

/*把我让他还不如我听话不温柔他还不如他还不如我退回给我让他不会污染天河北我让他不会*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
