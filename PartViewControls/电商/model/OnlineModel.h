//
//  OnlineModel.h
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineModel : NSObject
/*
 caBei = 10;
 color = "<null>";
 cover = 1;
 discription = 1;
 goodsID = 12;
 name = "iphone8  plus";
 picVidList =         (
 );
 price = 1;
 salesGoodsID = 0;
 salesID = 0;
 style = 1;
 total = 0;
 type = 1;
 },
 */
/**
*  咖贝
*/
@property (nonatomic,copy) NSString *caBei;        //咖呗
/**
 *  商品背景色
 */
@property (nonatomic,copy) NSString *color;        //商品背景色
/**
 *  商品封面照片
 */
@property (nonatomic,copy) NSString *cover;        //商品封面
/**
 *  商品描素
 */
@property (nonatomic,copy) NSString *discription;  //描述
/**
 *  商品ID
 */
@property (nonatomic,copy) NSString *goodsID;      //商品ID
/**
 *  商品名称
 */
@property (nonatomic,copy) NSString *name;         //商品名称
/**
 *  商品图片列表
 */
@property (nonatomic,strong) NSMutableArray *picVidList;  //图片视频列表
/**
 *  商品价格
 */
@property (nonatomic,copy) NSString *price;        //价格
/**
 *  R_SalesGoods表ID(购物车)
 */
@property (nonatomic,copy) NSString *salesGoodsID; //R_SalesGoods表ID(购物车)
/**
 *  用户订单
 */
@property (nonatomic,copy) NSString *salesID;      //用户订单ID（订单与购物车对应）
/**
 *  样式
 */
@property (nonatomic,copy) NSString *style;        //样式
/**
 *  购买数量
 */
@property (nonatomic,copy) NSString *total;        //购买数量
/**
 *  商品类型
 */
@property (nonatomic,copy) NSString *type;         //商品类型1:新品2:折扣品3:明星限量
/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL selected;       //是否选中


@end
