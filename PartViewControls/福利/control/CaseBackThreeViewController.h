//
//  CaseBackThreeViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/6.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface CaseBackThreeViewController : BaseViewController
/**
 *  订单号
 */
@property (nonatomic, copy) NSString *ordersn;
/**
 *  支付宝账号
 */
@property (weak, nonatomic) IBOutlet UILabel *alipayaccountLabel;
/**
 *  支付宝姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *aliUserNameLabel;

@property (nonatomic, copy) NSString *alipayAccount;
@property (nonatomic, copy) NSString *aliUseName;
/**
 *  确认提现
 *
 *  @param sender sender
 */
- (IBAction)sureCase:(UIButton *)sender;



@end
