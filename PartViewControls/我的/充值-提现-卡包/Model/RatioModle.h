//
//  RatioModle.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/17.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RatioModle : NSObject
/*
 max = 299;
 min = 100;
 ratio = "1.1";
 */
/**
*  最大值
*/
@property (nonatomic, copy) NSString *max;
/**
 *  最小值
 */
@property (nonatomic, copy) NSString *min;
/**
 *  兑换比率
 */
@property (nonatomic, copy) NSString *ratio;

@end
