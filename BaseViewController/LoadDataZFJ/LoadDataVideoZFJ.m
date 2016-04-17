//
//  LoadDataVideoZFJ.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/11/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

//下载缓存视频的类

#import "LoadDataVideoZFJ.h"

@implementation LoadDataVideoZFJ

- (void)downloadObject:(NSString *)ObjectKey
{
    //先判断本地有没有
    __block NSData *data;
    NSString *filename = [ObjectKey stringFromMD5];
    NSString *fullPath = [self filePath:filename];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:fullPath])
    {
        //从本地读取
        data = [NSData dataWithContentsOfFile:fullPath];
    }
    else
    {
        //网络下载
        [OSSLog enableLog];
        //__block LoadDataVideoZFJ *mySelf = self;
        [OSSHelper downloadObject:ObjectKey success:^id(OSSTask *task) {
            //获取下载的东西
            OSSGetObjectResult *result = task.result;
            //获取data
            data = result.downloadedData;
            //存到本地
            [data writeToFile:fullPath atomically:YES];
            
            return nil;
        }];
    }

}

//将文件存在本地
- (NSString *)filePath:(NSString *)fileName
{
    NSString *homePath = NSHomeDirectory();
    homePath = [homePath stringByAppendingPathComponent:@"Documents/DataCache"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:homePath])
    {
        [fm createDirectoryAtPath:homePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(fileName && fileName.length !=0)
    {
        homePath = [homePath stringByAppendingPathComponent:fileName];
    }
    NSNotification *notif = [NSNotification notificationWithName:@"HAVE_GET_VIDEO_DATA" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notif];
    //NSLog(@"Data保存的路径为   --------------   %@",homePath);
    return homePath;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
