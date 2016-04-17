//
//  OSSHelper.m
//  OSSTest
//
//  Created by Leo on 15/10/23.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "OSSHelper.h"

NSString * const accessKey = @"zfbLQYO1nuWJvOZo";
NSString * const secretKey = @"esCAN1PoOmNxD0gsQoSbUYOHfPQ1zk";
NSString * const endPoint = @"http://oss-cn-hangzhou.aliyuncs.com";
NSString * const bucketName = @"tongchuan";

NSString * const imageBucketName = @"tongchuan-image";         //(CDN图片加速)
NSString * const videoBucketName = @"tongchuan-video";         //(CDN视频加速)


static OSSClient *client;

@implementation OSSHelper

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // for test environment
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:accessKey secretKey:secretKey];
        OSSClientConfiguration * conf = [OSSClientConfiguration new];
        conf.maxRetryCount = 3;
        conf.enableBackgroundTransmitService = YES;
        conf.timeoutIntervalForRequest = 15;
        conf.timeoutIntervalForResource = 24 * 60 * 60;
        
        client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
    });
}
//上传图片CDN图片加速
+ (void)uploadImageObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type progress:(void (^)(int64_t, int64_t, int64_t))progress success:(id (^)(OSSTask *))success
{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = imageBucketName;
    put.objectKey = ObjectKey;
    put.uploadingData = data;
    put.uploadProgress = progress;
    
    OSSTask * putTask = [client putObject:put];
    if (type == OSSHelperOperationTypeSynchronous) {
        [putTask waitUntilFinished];
    }
    
    [putTask continueWithSuccessBlock:success];
    
}
//异步上传快速图片
+ (void)uploadImageObjectWithKey:(NSString *)ObjectKey data:(NSData *)data success:(id (^)(OSSTask *task))success
{
    [self uploadImageObjectWithKey:ObjectKey data:data type:OSSHelperOperationTypeAsynchronous progress:nil success:success];
}
//上传视频的方法
+ (void)uploadVideoObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type progress:(void (^)(int64_t, int64_t, int64_t))progress success:(id (^)(OSSTask *))success
{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = videoBucketName;
    put.objectKey = ObjectKey;
    put.uploadingData = data;
    put.uploadProgress = progress;
    
    OSSTask * putTask = [client putObject:put];
    if (type == OSSHelperOperationTypeSynchronous) {
        [putTask waitUntilFinished];
    }
    
    [putTask continueWithSuccessBlock:success];
}
//快速上传视频的方法
+ (void)uploadVideoObjectWithKey:(NSString *)ObjectKey data:(NSData *)data success:(id (^)(OSSTask *task))success
{
    [self uploadVideoObjectWithKey:ObjectKey data:data type:OSSHelperOperationTypeAsynchronous progress:nil success:success];
    
}
+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type progress:(void (^)(int64_t, int64_t, int64_t))progress success:(id (^)(OSSTask *))success {
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = bucketName;
    put.objectKey = ObjectKey;
    put.uploadingData = data;
    put.uploadProgress = progress;
    
    OSSTask * putTask = [client putObject:put];
    
    if (type == OSSHelperOperationTypeSynchronous) {
        [putTask waitUntilFinished];
    }
    
    [putTask continueWithSuccessBlock:success];
}

+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type success:(id (^)(OSSTask *task))success {
    [self uploadObjectWithKey:ObjectKey data:data type:type progress:nil success:success];
}

+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data progress:(void (^)(int64_t, int64_t, int64_t))progress success:(id (^)(OSSTask *))success {
    [self uploadObjectWithKey:ObjectKey data:data type:OSSHelperOperationTypeAsynchronous progress:progress success:success];
}

+ (BOOL)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data type:(OSSHelperOperationType)type
{
    __block BOOL isScu;
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = bucketName;
    put.objectKey = ObjectKey;
    put.uploadingData = data;
    
    OSSTask * putTask = [client putObject:put];
    
    [putTask waitUntilFinished];
    
    [putTask continueWithBlock:^id(BFTask *task) {
        ///
        if (task.result != nil) {
            isScu = YES;
        } else {
            isScu = NO;
        }
        return nil;
    }];
    return isScu;
}

+ (void)uploadObjectWithKey:(NSString *)ObjectKey data:(NSData *)data success:(id (^)(OSSTask *task))success {
    [self uploadObjectWithKey:ObjectKey data:data type:OSSHelperOperationTypeAsynchronous success:success];
}

+ (void)downloadObject:(NSString *)ObjectKey type:(OSSHelperOperationType)type progress:(void (^)(int64_t, int64_t, int64_t))progress success:(id (^)(OSSTask *))success {
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    
    request.bucketName = bucketName;
    request.objectKey = ObjectKey;
    request.downloadProgress = progress;
    
    OSSTask * getTask = [client getObject:request];
    
    if (type == OSSHelperOperationTypeSynchronous) {
        [getTask waitUntilFinished];
    }
    
    [getTask continueWithSuccessBlock:success];
}

+ (void)downloadObject:(NSString *)ObjectKey type:(OSSHelperOperationType)type success:(id (^)(OSSTask *task))success {
    [self downloadObject:ObjectKey type:type progress:nil success:success];
}

+ (void)downloadObject:(NSString *)ObjectKey progress:(void (^)(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend))progress success:(id (^)(OSSTask *task))success {
    [self downloadObject:ObjectKey type:OSSHelperOperationTypeAsynchronous progress:progress success:success];
}

+ (void)downloadObject:(NSString *)ObjectKey success:(id (^)(OSSTask *task))success {
    [self downloadObject:ObjectKey progress:nil success:success];
}

+ (void)deleteObject:(NSString *)ObjectKey success:(id (^)(OSSTask *task))success {
    OSSDeleteObjectRequest * delete = [OSSDeleteObjectRequest new];
    delete.bucketName = bucketName;
    delete.objectKey = ObjectKey;
    
    OSSTask * deleteTask = [client deleteObject:delete];
    
    [deleteTask continueWithSuccessBlock:success];
}

@end
