//
//  TwoShoppingCartController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface TwoShoppingCartController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tbView;

/**
 *  底部结算视图
 */
@property (weak, nonatomic) IBOutlet UIView *SettelButtomView;

/**
 *  全选的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;

- (IBAction)selectAllBtnClick:(UIButton *)sender;
/**
 *  点击了删除的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)deleteBtnClick:(UIButton *)sender;
/**
 *  点击了结算的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)settelBtnClick:(UIButton *)sender;
@end
