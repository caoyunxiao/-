//
//  ExchangeModle.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeModle : NSObject
/*
 amount = 500;
 exchangeTime = "/Date(1447654475357+0800)/";
 kaBei = 50000;
 orderSN = CZ15111614143531462;

 */
/**
 *  充值金额
 */
@property (nonatomic, copy) NSString *amount;
/**
 *  充值时间
 */
@property (nonatomic, copy) NSString *exchangeTime;
/**
 *  充值咖贝
 */
@property (nonatomic, copy) NSString *kaBei;
/**
 *  充值订单
 */
@property (nonatomic, copy) NSString *orderSN;

@end
