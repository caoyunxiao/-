//
//  PersonalHomepageController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "SupportModel.h"

@interface PersonalHomepageController : BaseViewController
/**
 *  背景滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *bgScroller;
/**
 *  头像按钮
 */
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/**
 *  电话号码
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
/**
 *  区域
 */
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

- (IBAction)tapDreamHistory:(UITapGestureRecognizer *)sender;

/**
 *  梦想秀Label
 */
@property (nonatomic, strong) SupportModel *model;
/*也对他和她的汇报和退换货*/
/**
 *  是否曹传过来的
 */
@property (nonatomic, assign) BOOL isCao;
/**
 *  传过来的用户ID
 */
@property (nonatomic, copy) NSString *userid;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backClick:(UIButton *)sender;

@end
