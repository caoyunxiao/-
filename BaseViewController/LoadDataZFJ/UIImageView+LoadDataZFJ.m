//
//  UIImageView+LoadDataZFJ.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "UIImageView+LoadDataZFJ.h"

@implementation UIImageView (LoadDataZFJ)

//通过阿里云的OSS的ObjectKey加载图片，并实现图片缓存
- (void)setImageWithObjectKey:(NSString *)ObjectKey placeholderImage:(UIImage *)placeholder
{
   
    //先判断本地有没有
    __block NSData *data;
    self.image = placeholder;
    NSString *filename = [ObjectKey stringFromMD5];
    NSString *fullPath = [self filePath:filename];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:fullPath])
    {
        //从本地读取
        data = [NSData dataWithContentsOfFile:fullPath];
        
        UIImage *image = [UIImage imageWithData:data];
        
        self.image = image;
    }
    else
    {
        //网络下载
        [OSSLog enableLog];
        __block UIImageView *myImageView = self;
        [OSSHelper downloadObject:ObjectKey success:^id(OSSTask *task) {
            //获取下载的东西
            OSSGetObjectResult *result = task.result;
            //获取data
            data = result.downloadedData;
            //存到本地
            [data writeToFile:fullPath atomically:YES];
            //设置图片
            UIImage *image = [UIImage imageWithData:data];
            
            myImageView.image = image;
            
            return nil;
        }];
    }
}

//通过url加载图片，并实现永久缓存
- (void)setImageWithURLOfZFJ:(NSString *)url placeholderImage:(UIImage *)placeholder
{
    NSData *data;
    NSString *filename = [url stringFromMD5];
    NSString *fullPath = [self filePath:filename];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:fullPath])
    {
        //从本地读取
        data = [NSData dataWithContentsOfFile:fullPath];
        [self setImage:[UIImage imageWithData:data]];
    }
    else
    {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        //网络下载
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
        //存到本地
        [data writeToFile:fullPath atomically:YES];
    }

}

//将文件存在本地  图片保存的路径
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
    //NSLog(@"Data保存的路径为   --------------   %@",homePath);
    return homePath;
}







@end
