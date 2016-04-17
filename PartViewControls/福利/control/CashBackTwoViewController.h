//
//  CashBackTwoViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/6.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface CashBackTwoViewController : BaseViewController
/**
 *  背景滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollerView;

/**
 *  支付宝账户
 */
@property (weak, nonatomic) IBOutlet UITextField *alipayAccountLabel;
/**
 *  支付宝账号姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *alipayUserNameLabel;

@property (nonatomic, copy) NSString *orserSN;

/**
 *  提现金
 *
 *  @param sender <#sender description#>
 */
- (IBAction)Case:(id)sender;
/**
 *  订单号
 */
@property (nonatomic, copy) NSString *ordersn;
@end
