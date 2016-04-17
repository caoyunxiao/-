//
//  BuyDownView.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineModel.h"     //商品模型

@interface BuyDownView : UIView

/**
 *  减
 */
@property (weak, nonatomic) IBOutlet UIButton *buyReductionBtm;//减
/**
 *  加
 */
@property (weak, nonatomic) IBOutlet UIButton *buyAddButton;//加
/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;//数量
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *buyImageView;//商品图片
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *buyName;//商品名
/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *buyPrice;//商品价格
/**
 *  商品分类
 */
@property (weak, nonatomic) IBOutlet UILabel *buyClass;//商品分类
/**
 *  咖贝
 */
@property (weak, nonatomic) IBOutlet UILabel *kabeiLabel;
/**
 *  确认按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

/**
 *  点击确认的按钮
 *
 *  @param sender sender
 */
- (IBAction)sureBtnClick:(UIButton *)sender;

- (void)configModel:(OnlineModel *)model;

@end
