//
//  NewPasswordViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "NewPasswordViewController.h"

#import "LGIndexViewController.h"
@interface NewPasswordViewController ()

@end

@implementation NewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self uiConfig];
}

- (void)uiConfig
{
    self.nikeNameLabel.text = [PersonInfo sharePersonInfo].nickname;
    
    //消除导航栏的影响
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.title = @"修改密码";
    //设置背景View的边框
    [self setuUpViewBoard:self.nicknameView];
    
    [self setuUpViewBoard:self.lastPasswordView];
    
    [self setuUpViewBoard:self.reEditView];
    
    [self setuUpViewBoard:self.oldPasswordView];
    //设置确认按钮的圆角
    self.sureBtn.layer.cornerRadius = 2;
    self.sureBtn.layer.masksToBounds = YES;
    
    
}

//抽方法
- (void)setuUpViewBoard:(UIView *)view
{
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1;
}

- (IBAction)sureBtnClick:(UIButton *)sender {
    
    
    if(self.oldPassWordText.text.length<=0)
    {
        Alert(@"请输入你的密码");
        return;
    }
   // NSLog(@"原密码%@",[PersonInfo sharePersonInfo].passWord);
    if (![self.oldPassWordText.text isEqualToString:[PersonInfo sharePersonInfo].passWord]) {
        Alert(@"原密码不正确");
        
        return;
    }
    if (self.lastPassWordTextField.text.length<6||self.lastPassWordTextField.text.length>12
        ) {
        Alert(@"请输入你的新密码");
        return;
    }
    if(![self.lastPassWordTextField.text isEqualToString:self.reEditTextField.text])
    {
        Alert(@"两次密码输入不一样");
        return;
    }
    
    NSString *newPassWord = [self collegePasswordEncryptionAlgorithm:self.reEditTextField.text];
    

    //NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userName,@"pwd":newPassWord};
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userName,@"userid",newPassWord,@"pwd", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"102" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            Alert(@"密码修改成功");
            //修改本地存储的密码
            [PersonInfo sharePersonInfo].passWord = newPassWord;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
            [defaults setObject:newPassWord forKey:@"passWord"];
           // [self.navigationController popoverPresentationController];
//            [PersonInfo sharePersonInfo].isLogIn = NO;
//            [[PersonInfo sharePersonInfo] resetPersonInfo];
//            LGIndexViewController *lvc = [[LGIndexViewController alloc]init];
//            lvc.isPresent = YES;
//            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
//            [self presentViewController:nvc animated:YES completion:nil];

        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"密码修改失败");
        }
    }];

}
@end
