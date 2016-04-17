//
//  NSArray+crossing.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/16.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*防止数组越界*/

#import <Foundation/Foundation.h>

@interface NSArray (crossing)

- (id)objectAtQYQIndex:(NSUInteger)index;

@end
