//
//  NSArray+crossing.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/16.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "NSArray+crossing.h"

@implementation NSArray (crossing)

- (id)objectAtQYQIndex:(NSUInteger)index
{
    if (index>=self.count) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    
    if (value == [NSNull null]) {
        return nil;
    }
    
    
    return value;
    
}
@end
