//
//  SettleCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*********结算的cell**********/

#import <UIKit/UIKit.h>
#import "OnlineModel.h"

@interface SettleCell : UITableViewCell

/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
/**
 *  商品描素
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsDescLabel;
/**
 *  商品人民比价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/**
 *  咖贝价格
 */
@property (weak, nonatomic) IBOutlet UILabel *kabeiLabel;

/**
 *  商品款式
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsStyleLabel;
/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *goosCountLabel;

//- (IBAction)selectBTnClick:(UIButton *)sender;

/**
 *  传递数据模型
 *
 *  @param model 模型
 */
- (void)configModel:(OnlineModel *)model;

@end
