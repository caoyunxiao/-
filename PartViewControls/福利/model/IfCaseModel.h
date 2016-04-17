//
//  IfCaseModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/18.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*判断是否返现的数据模型*/

#import <Foundation/Foundation.h>

@interface IfCaseModel : NSObject
/*
 {
 amount = 1000;
 kabei = 0;
 orderSN = CZ15101614015524777;
 payTime = "/Date(1444975315123+0800)/";
 }
 
 */
/**
 *  返现金额
 */
@property (nonatomic, copy) NSString *amount;
/**
 *  咖贝
 */
@property (nonatomic, copy) NSString *kabei;
/**
 *  订单号
 */
@property (nonatomic, copy) NSString *orderSN;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *payTime;

@end






