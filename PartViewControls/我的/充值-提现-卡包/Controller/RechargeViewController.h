//
//  RechargeViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface RechargeViewController : BaseViewController



@property (weak, nonatomic) IBOutlet UIScrollView *bgScroller;

@property (weak, nonatomic) IBOutlet UIButton *oneYuanBtn;

/**
 *  10
 */
@property (weak, nonatomic) IBOutlet UIButton *tenYuanBtn;
/**
 *  50
 */
@property (weak, nonatomic) IBOutlet UIButton *fifYuanBtn;
/**
 *  100
 */
@property (weak, nonatomic) IBOutlet UIButton *oneHBtn;
/**
 *  300
 */
@property (weak, nonatomic) IBOutlet UIButton *threeHYuanBtn;
/**
 *  200
 */
@property (weak, nonatomic) IBOutlet UIButton *twoHBtn;
/**
 *  400
 */
@property (weak, nonatomic) IBOutlet UIButton *fourHBtn;

/**
 *  500
 */
@property (weak, nonatomic) IBOutlet UIButton *fiveHBtn;
/**
 *  充值的金额输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *rechargreTextField;
/**
 *  立即支持
 */
@property (weak, nonatomic) IBOutlet UIButton *supportBtn;
/**
 *  输入的背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *inputView;
/**
 *  用来接收支付宝按钮
 */
@property (nonatomic, strong) UIButton *selectAlipayBtn;
/**
 *  用来接收微信按钮
 */
@property (nonatomic, strong) UIButton *selectWixinBtn;

- (IBAction)oneYuanClick:(UIButton *)sender;

- (IBAction)tenYuanClick:(UIButton *)sender;

- (IBAction)fifYuanClick:(UIButton *)sender;

- (IBAction)oneHClick:(UIButton *)sender;


- (IBAction)twoHClick:(UIButton *)sender;


- (IBAction)threeHBtnClick:(UIButton *)sender;

- (IBAction)fourBtnClick:(UIButton *)sender;


- (IBAction)fiveHBtnClick:(UIButton *)sender;


- (IBAction)supportClick:(UIButton *)sender;

@end
