//
//  MycheckViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface MycheckViewController : BaseViewController
/**
 *  充值按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *reCahargeBtn;

/**
 *  兑换按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *exchargeBtn;
/**
 *  打赏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *rewardBtn;

/**
 *  订单按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;

@property (weak, nonatomic) IBOutlet UITableView *tbView;

/**
 *  点击充值记录
 *
 *  @param sender 充值
 */
- (IBAction)reChargeClick:(UIButton *)sender;
/**
 *  点击兑换按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)exchargeClick:(UIButton *)sender;

/**
 *  点击打赏按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)rewardBtnClick:(UIButton *)sender;
/**
 *  点击订单的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)orderClick:(UIButton *)sender;

@property (nonatomic, assign) BOOL isBuy;
@end
