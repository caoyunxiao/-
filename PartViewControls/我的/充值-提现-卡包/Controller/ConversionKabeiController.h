//
//  ConversionKabeiController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface ConversionKabeiController : BaseViewController
/**
 *  背景视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollerView;

/*ergergergetgrg3rg3rgrgerge*/

//咖贝的筹码
//1
@property (weak, nonatomic) IBOutlet UIView *oneView;

- (IBAction)oneViewTap:(UITapGestureRecognizer *)sender;

//10
@property (weak, nonatomic) IBOutlet UIView *TenView;

- (IBAction)tenViewTap:(UITapGestureRecognizer *)sender;
//50
@property (weak, nonatomic) IBOutlet UIView *FifteenView;
- (IBAction)FifteenTap:(UITapGestureRecognizer *)sender;
//100
@property (weak, nonatomic) IBOutlet UIView *OneHSView;
- (IBAction)OneHTap:(UITapGestureRecognizer *)sender;

//200
@property (weak, nonatomic) IBOutlet UIView *TwoHView;

- (IBAction)TwoViewTap:(UITapGestureRecognizer *)sender;

//300
@property (weak, nonatomic) IBOutlet UIView *ThreenHView;
- (IBAction)threenHTap:(UITapGestureRecognizer *)sender;
//400
@property (weak, nonatomic) IBOutlet UIView *fourHView;

- (IBAction)fourHTap:(UITapGestureRecognizer *)sender;

//500
@property (weak, nonatomic) IBOutlet UIView *FiveHView;
- (IBAction)fiveHTAp:(UITapGestureRecognizer *)sender;

/**
 *  输入金额
 */
@property (weak, nonatomic) IBOutlet UIView *imputMonery;

@property (weak, nonatomic) IBOutlet UITextField *inputMoney;
/**
 *  兑换比率
 */
@property (weak, nonatomic) IBOutlet UILabel *ratioLabel;

/**
 *  显示金额
 */
@property (weak, nonatomic) IBOutlet UIView *showMoney;
/**
 *  显示咖贝的Label
 */
@property (weak, nonatomic) IBOutlet UILabel *showLabel;


@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;




- (IBAction)sureBtnClick:(UIButton *)sender;

@end









