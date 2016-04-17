//
//  ForgetPasswordViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/28.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"


@interface ForgetPasswordViewController : BaseViewController{
    NSTimer *_myTimer;//定时器
    int _iTimer;
    NSInteger _sentTimers;
}


//手机号
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

//验证码
@property (weak, nonatomic) IBOutlet UIView *VerificationView;
@property (weak, nonatomic) IBOutlet UITextField *VerificationText;

//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *getVerification;
- (IBAction)getVerificationClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *getVerificationLabel;

//找回密码
@property (weak, nonatomic) IBOutlet UIButton *findPassWord;
- (IBAction)findPassWordClick:(UIButton *)sender;




@end
