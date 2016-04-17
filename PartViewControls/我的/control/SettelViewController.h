//
//  SettelViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /******购物车结算*******/

#import "BaseViewController.h"

@interface SettelViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tbView;
/**
 *  余额购买显示
 */
@property (weak, nonatomic) IBOutlet UILabel *priceBuyLabel;
/**
 *  咖贝购买显示
 */
@property (weak, nonatomic) IBOutlet UILabel *kabeiBuyLabel;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


/**
 *  余额购买按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *balabceBtn;
/**
 *  咖贝购买按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *kabeiBtn;

/**
 *  点击了余额购买
 *
 *  @param sender <#sender description#>
 */
//- (IBAction)balanceBuyClick:(UIButton *)sender;
//
///**
// *  点击了咖贝购买
// *
// *  @param sender <#sender description#>
// */
//- (IBAction)kabeiBuyClick:(UIButton *)sender;


- (IBAction)balanceBuyTAp:(UITapGestureRecognizer *)sender;


- (IBAction)kaibeiBuyTap:(UITapGestureRecognizer *)sender;


/**
 *  确认付款
 *
 *  @param sender <#sender description#>
 */
- (IBAction)verifyBtnClick:(UIButton *)sender;

/**
 *  商品的数组
 */
@property (nonatomic, strong) NSMutableArray *goodArr;
@end
