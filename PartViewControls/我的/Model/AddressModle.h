//
//  AddressModle.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/31.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModle : NSObject
/*
 userid
 name
 mobile
 addr
 zip
 gender
 */
/**
*  用户ID
*/
@property (nonatomic, copy) NSString *userid;
/**
 *  收货人名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 *  地址
 */
@property (nonatomic, copy) NSString *addr;
/**
 *  邮编
 */
@property (nonatomic, copy) NSString *zip;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *gender;



@end
