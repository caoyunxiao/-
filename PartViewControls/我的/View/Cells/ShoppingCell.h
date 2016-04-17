//
//  ShoppingCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ShoppingModel.h"
#import "OnlineModel.h"

@interface ShoppingCell : UITableViewCell

/**
 *  选中的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
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
