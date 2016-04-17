//
//  PayModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayModel : NSObject
/*
NSString *amount = dataArr[0][@"amount"];
NSString *parternerid = dataArr[0][@"partner"];
NSString *itBpay = dataArr[0][@"itBPay"];
NSString *tradeNo = dataArr[0][@"tradeNO"];
*/
/**
*  充值金额
*/
@property (nonatomic, copy) NSString *amount;
/**
 *  合作者身份ID
 */
@property (nonatomic, copy) NSString *partner;
/**
 *  交易超时时间
 */
@property (nonatomic, copy) NSString *itBPay;

/**
 *  订单号
 */
@property (nonatomic, copy) NSString *tradeNO;

@end
