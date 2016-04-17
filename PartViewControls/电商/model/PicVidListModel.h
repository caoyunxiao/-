//
//  PicVidListModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicVidListModel : NSObject
/*
 createTime = "/Date(1448008152460+0800)/";
 describe = "";
 goodsID = 45;
 iD = 43;
 state = 0;
 type = 1;
 url = "goods/good_20151120162912.jpg";
 */
/**
 *  商品时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 *  描素
 */
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, copy) NSString *iD;
@property (nonatomic, copy) NSString *state;
/**
 *  类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  图片URL
 */
@property (nonatomic, copy) NSString *url;
@end
