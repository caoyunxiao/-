//
//  NewPasswordViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface NewPasswordViewController : BaseViewController
/**
 *  用户昵称背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *nicknameView;
/**
 *  用户昵称的Label
 */
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;

/**
 *  新密码背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *lastPasswordView;
@property (weak, nonatomic) IBOutlet UITextField *lastPassWordTextField;

/**
 *  再次输入密码
 */
@property (weak, nonatomic) IBOutlet UIView *reEditView;
/**
 *  再次输入密码的编辑框
 */
@property (weak, nonatomic) IBOutlet UITextField *reEditTextField;



/**
 *  原来的密码背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *oldPasswordView;
/**
 *  原来的密码编辑框
 */
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordText;


//确认按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
/**
 *  点击确认按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)sureBtnClick:(UIButton *)sender;

@end
