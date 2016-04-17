//
//  RegisterViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/28.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UMSocial.h"

@interface RegisterViewController : BaseViewController{
    NSTimer *_myTimer;//定时器
    int _iTimer;
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

//邀请码
@property (weak, nonatomic) IBOutlet UIView *InviteCodeView;
@property (weak, nonatomic) IBOutlet UITextField *InviteCodeText;


//用户名
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;

//密码
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

//验证密码
@property (weak, nonatomic) IBOutlet UIView *sureView;
@property (weak, nonatomic) IBOutlet UITextField *sureText;

//注册
- (IBAction)registered:(UIButton *)sender;


@property (nonatomic,copy) NSString *typeStr;//登录类型  1 qq \2 wechat \3 sina \4 默认方式
//第三方登录信息
@property (nonatomic,retain) UMSocialAccountEntity *snsAccount;


@end
