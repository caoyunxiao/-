//
//  OSSHelper.h
//  OSSTest
//
//  Created by Leo on 15/10/23.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

// OSS
#import <AliyunOSSiOS/OSSService.h>

typedef NS_ENUM(NSInteger, OSSHelperOperationType) {
    OSSHelperOperationTypeAsynchronous,
    OSSHelperOperationTypeSynchronous
};

@interface OSSHelper : NSObject

// upload relate
+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type progress:(void (^)(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend))progress success:(id (^)(OSSTask *task))success;

//bytesSent 当前正在上传的数据量
//totalByteSent  已经上传的
//totalBytesExpectedToSend
+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data progress:(void (^)(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend))progress success:(id (^)(OSSTask *task))success;

//ObjectKey 
+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type success:(id (^)(OSSTask *task))success;

+ (BOOL)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type;

+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data success:(id (^)(OSSTask *task))success;


// download relate
+ (void)downloadObject:(NSString *)ObjectKey type:(OSSHelperOperationType)type progress:(void (^)(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend))progress success:(id (^)(OSSTask *task))success;

+ (void)downloadObject:(NSString *)ObjectKey type:(OSSHelperOperationType)type success:(id (^)(OSSTask *task))success;

+ (void)downloadObject:(NSString *)ObjectKey progress:(void (^)(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend))progress success:(id (^)(OSSTask *task))success;

+ (void)downloadObject:(NSString *)ObjectKey success:(id (^)(OSSTask *task))success;


+ (void)uploadImageObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type progress:(void (^)(int64_t, int64_t, int64_t))progress success:(id (^)(OSSTask *))success;
//上传视频的方法
+ (void)uploadVideoObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type progress:(void (^)(int64_t, int64_t, int64_t))progress success:(id (^)(OSSTask *))success;
// delete relate

+ (void)deleteObject:(NSString *)ObjectKey success:(id (^)(OSSTask *task))success;
/**
 *  异步上传图片
 *
 *  @param sender ObjectKey
    @param sender data
    @param sender success
 */
+ (void)uploadImageObjectWithKey:(NSString *)ObjectKey data:(NSData *)data success:(id (^)(OSSTask *task))success;
/**
 *  异步上传视频
 *
 *  @param sender ObjectKey
    @param sender data
    @param sender success
 */
+ (void)uploadVideoObjectWithKey:(NSString *)ObjectKey data:(NSData *)data success:(id (^)(OSSTask *task))success;
@end






