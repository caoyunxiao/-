//
//  BuySuccessController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface BuySuccessController : BaseViewController


@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backClick:(UIButton *)sender;

/**
 *  查看我的账单
 *
 *  @param sender <#sender description#>
 */

- (IBAction)checkBtn:(UIButton *)sender;


@end
