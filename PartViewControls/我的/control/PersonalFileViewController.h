//
//  PersonalFileViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/4.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*******个人信息视图 ******/

#import "BaseViewController.h"
#import "UMSocial.h"

@interface PersonalFileViewController : BaseViewController


/**
 *  背景滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollerView;
/**
 *  头像按钮
 */
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

/**
 *  点击头像
 *
 *  @param sender <#sender description#>
 */
- (IBAction)HeaderIamgeTap:(UITapGestureRecognizer *)sender;

//用户昵称
@property (weak, nonatomic) IBOutlet UIView *nikeNameView;

@property (weak, nonatomic) IBOutlet UITextField *nikeNameTextField;
- (IBAction)nikeNameTextField:(UITextField *)sender;

//自我介绍
@property (weak, nonatomic) IBOutlet UIView *introduceView;
@property (weak, nonatomic) IBOutlet UITextField *introduceTextField;


//性别
@property (weak, nonatomic) IBOutlet UIView *genderView;

@property (weak, nonatomic) IBOutlet UILabel *genderName;

- (IBAction)tapGenderLabel:(UITapGestureRecognizer *)sender;

//年龄
@property (weak, nonatomic) IBOutlet UIView *ageView;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;



//邮箱
@property (weak, nonatomic) IBOutlet UIView *EmailView;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;


//确认保存
@property (weak, nonatomic) IBOutlet UIButton *sureSaveBtn;
/**
 *  点击确认保存
 *
 *  @param sender <#sender description#>
 */
- (IBAction)sureSaveClick:(UIButton *)sender;


//第三方登录信息
@property (nonatomic,retain) UMSocialAccountEntity *snsAccount;

@property (nonatomic,assign) BOOL isPress;

@property (nonatomic,assign) BOOL isBackhome; //是否返回主页


@end
