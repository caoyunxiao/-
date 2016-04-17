//
//  SettingGroup.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject


/**
 *  组的头部标题
 */
@property(nonatomic,copy)NSString *headerTitle;

/**
 *  组的尾部标题
 */
@property(nonatomic,copy)NSString *footerTitle;


/**
 *  组的每一行数据模型
 */
@property(nonatomic,strong)NSArray *items;
@end
