//
//  ShoppingModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject
/*
 color = "<null>";
 cover = "1.jpg";
 discription = "\U624b\U673a";
 goodsID = 4;
 name = "iphone6 plus";
 picVidList =         (
 );
 price = 6000;
 salesGoodsID = 6;
 salesID = 2;
 style = "\U9ed1";
 total = 2;
 type = 1;
 */
/**
*  商品颜色
*/
@property (nonatomic, copy) NSString *color;
/**
 *  商品图片
 */
@property (nonatomic, copy) NSString *cover;

/**
 *  商品描素
 */
@property (nonatomic, copy) NSString *discription;
/**
 *  商品编号
 */
@property (nonatomic, copy) NSString *goodsID;
/**
 *  商品名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  商品价格
 */
@property (nonatomic, copy) NSString *price;
/**
 *  商品出售ID
 */
@property (nonatomic, copy) NSString *salesGoodsID;

/**
 *  salesID
 */
@property (nonatomic, copy) NSString *salesID;
/**
 *  商品风格
 */
@property (nonatomic, copy) NSString *style;
/**
 *  商品类型
 */
@property (nonatomic, copy) NSString *type;

/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL selected;
/**
 *
 */


@end
