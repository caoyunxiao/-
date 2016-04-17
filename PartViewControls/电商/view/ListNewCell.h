//
//  ListNewCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineModel.h"

@interface ListNewCell : UITableViewCell

//ListNewCell
/**
 *  商品标题
 */
@property (weak, nonatomic) IBOutlet UILabel *ListTitle;
/**
 *  商品描素
 */
@property (weak, nonatomic) IBOutlet UILabel *ListDescribe;
/**
 *  商品分类
 */
@property (weak, nonatomic) IBOutlet UILabel *ListNewClass;
/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *ListNewprice;//
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

/**
 *  咖贝的Label
 */
@property (weak, nonatomic) IBOutlet UILabel *kabeiLabel;

- (void)showUIViewWithModel:(OnlineModel *)model;


@end
