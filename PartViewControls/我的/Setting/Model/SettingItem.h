//
//  SettingItem.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义一个block,无返回值，也无参数
typedef void (^OperationBlock)();

@interface SettingItem : NSObject

@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *subTitle;//子标题

/**
 * 控制器的类型
 */
@property(nonatomic, assign)Class vcClass;

/**
 *  存储一个特殊的Block 操作
 *   block 使用copy
 */
@property(nonatomic,copy)OperationBlock operation;


-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle vcClass:(Class)vcClass;
@end
