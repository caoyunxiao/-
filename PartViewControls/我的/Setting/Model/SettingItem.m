//
//  SettingItem.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem


-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title{
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
    }
    
    return self;
}
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title{
    return [[self alloc] initWithIcon:icon title:title];
}

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass{
    SettingItem *item = [self itemWithIcon:icon title:title];
    item.vcClass = vcClass;
    
    return item;
}

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle vcClass:(Class)vcClass{
    SettingItem *item = [self itemWithIcon:icon title:title];
    item.subTitle = subTitle;
    item.vcClass = vcClass;
    
    return item;
}

@end
