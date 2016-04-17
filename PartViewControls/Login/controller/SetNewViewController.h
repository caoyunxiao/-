//
//  SetNewViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface SetNewViewController : BaseViewController

@property (nonatomic,copy) NSString *verificationStr;//验证码
@property (nonatomic,copy) NSString *userid;//用户ID  手机号

//用户名
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UILabel *userNameText;

//密码
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

//验证密码
@property (weak, nonatomic) IBOutlet UIView *sureView;
@property (weak, nonatomic) IBOutlet UITextField *sureText;

//确定
@property (weak, nonatomic) IBOutlet UIButton *sureSetBtn;
- (IBAction)sureSetBtn:(UIButton *)sender;

@end
