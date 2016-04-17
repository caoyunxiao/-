//
//  RequestEngine.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/14.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestEngine : NSObject

//用户模块
+ (void)UserModulescollegeWithDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction completed:(void(^)(NSString *errorCode,NSDictionary *resultDict))completed;
//我的请求
+ (void)QyqModulescollegeWithDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction completed:(void(^)(NSString *errorCode,NSDictionary *resultDict))completed;
//验证用户是否已注册
+ (NSDictionary *)requestDataWithWParamDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction;

+ (id)getrequestDataWithWParamDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction;

@end
