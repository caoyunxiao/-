//
//  payPopupView.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /************弹出的支付视图*************************/

#import <UIKit/UIKit.h>

@protocol payPopupViewDelegate <NSObject>

@optional
- (void)payPopupViewDisMissClick;
/**
 *  选择支付宝进行支付
 *
 *  @param sender <#sender description#>
 */
- (void)payPopupViewaliPaySelectClick:(UIButton *)sender;
/**
 *  选择微信支付
 *
 *  @param sender <#sender description#>
 */
- (void)payPopupViewweixinPaySelect:(UIButton *)sender;
/**
 *  立即支付
 *
 *  @param sender <#sender description#>
 */
- (void)payPopupViepayOnceClick:(UIButton *)sender;
@end

@interface payPopupView : UIView



@property (nonatomic, assign) id<payPopupViewDelegate> delegate;
/**
 *  显示的金额
 */
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;


/**
 *  取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *disMissBtn;


/**
 *  选择支付宝
 */
@property (weak, nonatomic) IBOutlet UIButton *selectAlipayBTn;

/**
 *  选择微信
 */
@property (weak, nonatomic) IBOutlet UIButton *selectweixinBtn;

@property (weak, nonatomic) IBOutlet UIButton *payOnceBtn;

/**
 *  立即支付
 *
 *  @param sender <#sender description#>
 */



@end
