//
//  ProductDetailsCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OnlineModel.h"

@interface ProductDetailsCell : UITableViewCell{
    

}
/**
 *  广告滚动视图
 */
@property (weak, nonatomic) IBOutlet UIView *sDCScrollView;

/**
 *  商品人民币
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/**
 *  商品咖贝
 */
@property (weak, nonatomic) IBOutlet UILabel *kabeiLabel;

/**
 *  商品标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  商品介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *Introduction;
/**
 *  客服电话
 */
@property (weak, nonatomic) IBOutlet UIButton *CustomerSserviceTel;

/**
 *  展示第一个Cell
 *
 *  @param model 
 */
- (void)showUIViewOneCellWith:(OnlineModel *)model;
/**
 *  展示第二个Cell
 *
 *  @param model 商品描述
 */
- (void)showUIViewTwoCellWith:(OnlineModel *)model;


@end
