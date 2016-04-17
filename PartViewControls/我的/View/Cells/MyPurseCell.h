//
//  MyPurseCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyPurseCellDelegate <NSObject>

@optional

/**
 *  点击了充值的按钮
 */
- (void)MyPurseCellRechargeDidClick;

/**
 *  点击了兑换咖呗的按钮
 */
- (void)MyPurseCellkabaoBtnClick;
/**
 *  点击了我的账单按钮
 */
- (void)MyPurseCellMyCheckBtnClick;

@end
@interface MyPurseCell : UITableViewCell

/**
 *  余额
 */
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
/**
 *  咖贝
 */
@property (weak, nonatomic) IBOutlet UILabel *kabeiLabel;
/**
 *  点击了充值的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)rechargeBtnClick:(UIButton *)sender;

/**
 *  点击了兑换卡贝的按钮
 *
 *  @param sender <#sender description#>
 */

- (IBAction)kabaoBtnClick:(UIButton *)sender;
/**
 *  点击了我的账单的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)myCheck:(UIButton *)sender;

@property (nonatomic, assign) id<MyPurseCellDelegate> delegate;

@end
