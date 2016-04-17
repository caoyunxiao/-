//
//  RechargeModle.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModle : NSObject
/*
 amount = 500;
 cashBack = 0;
 kabei = 0;
 orderSN = CZ15111318053170527;
 payTime = "/Date(1447409131167+0800)/";
 */
@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *cashBack;

@property (nonatomic, copy) NSString *kabei;

@property (nonatomic, copy) NSString *orderSN;

@property (nonatomic, copy) NSString *payTime;

@end
