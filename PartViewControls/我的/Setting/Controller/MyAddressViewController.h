//
//  MyAddressViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface MyAddressViewController : BaseViewController
/**
 *  收货人背景View
 */
@property (weak, nonatomic) IBOutlet UIView *consigneeView;
/**
 *  收货人编辑框
 */
@property (weak, nonatomic) IBOutlet UITextField *consigneeTexitField;
/**
 *  地址背景
 */
@property (weak, nonatomic) IBOutlet UIView *addressView;
/**
 *  地址编辑框
 */
@property (weak, nonatomic) IBOutlet UITextField *adressTextField;
/**
 *  电话背景View
 */
@property (weak, nonatomic) IBOutlet UIView *phoneView;
/**
 *  电话号码编剧框
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;


@property (weak, nonatomic) IBOutlet UIView *postcodeView;
/**
 *  邮编编辑框
 */
@property (weak, nonatomic) IBOutlet UITextField *postcodeTextField;

/**
 *  保存按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
/**
 *  男性
 */
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
- (IBAction)manBtnClick:(UIButton *)sender;

/**
 *  女性
 */
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

- (IBAction)womanBtnClick:(UIButton *)sender;

/**
 *  点击保存按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)saveClick:(UIButton *)sender;




@end
