//
//  LoginViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/28.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

//手机号
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

//密码
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
//忘记密码
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
- (IBAction)forgetBtnClick:(UIButton *)sender;
//登录
@property (weak, nonatomic) IBOutlet UIButton *LogInBtn;
- (IBAction)LogInBtn:(UIButton *)sender;





@end
