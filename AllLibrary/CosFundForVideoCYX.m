//
//  CosFundForVideoCYX.m
//  CosFund
//
//  Created by 曹云霄 on 15/12/4.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CosFundForVideoCYX.h"

@implementation CosFundForVideoCYX

+ (CosFundForVideoCYX *)manager
{
    static CosFundForVideoCYX *CYX;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CYX = [[CosFundForVideoCYX alloc]init];
    });
    return CYX;
}

#pragma mark -发布梦想
/*
 *coverurl :封面URL
 *boolForDream:是否是视频
 *photoArray:图片数组
 *VideoURL:视频URL
 
 */
- (void)Releasedreamscover:(UIImage *)coverpath Andmediatype:(int)mediatype Anduserid:(NSString *)userid Andtitle:(NSString *)title Anddescribe:(NSString *)describe Andslogan:(NSString *)slogan Andminamount:(NSString *)minamount Andendtime:(NSString *)endtime Andlablelist:(NSString *)lablelist AndphotoArray:(NSArray *)photoArray orVideopath:(NSString *)Videopath Completed:(void(^)(NSString * errorCode, NSString*resultDict))completed
{
    //封面
    [OSSLog enableLog];
    NSData *coverdata = UIImageJPEGRepresentation(coverpath, 0.001);
    NSString *coverkey = [BaseViewController getOSSObjectKeyWithtype:@"png"];//封面key
    [OSSHelper uploadImageObjectWithKey:coverkey data:coverdata type:1 progress:nil success:^id(OSSTask *task) {
        
        //上传图片
        if (mediatype == 1) {
            
            NSMutableArray *keyarray = [NSMutableArray array];
            for (int i=0; i<photoArray.count; i++) {
                [keyarray addObject:[BaseViewController getOSSObjectKeyWithtype:@"png" index:i]];
            }
            NSString *photoKey = [keyarray componentsJoinedByString:@","];//图片key
            NSArray *imagearr;
            if (keyarray.count > 6) {
                
                NSRange rang = NSMakeRange(keyarray.count-6, keyarray.count);
                imagearr = [keyarray subarrayWithRange: rang];
            }else
            {
                imagearr = [NSArray arrayWithArray:keyarray];
            }
            
            for (int i=0; i< imagearr.count; i++) {
                
                
                [OSSHelper uploadImageObjectWithKey:[keyarray objectAtQYQIndex:i] data:UIImageJPEGRepresentation( [photoArray objectAtQYQIndex:i], 0.0001) type:1 progress:nil success:^id(OSSTask *taskPhoto) {
                    
                    if (i == photoArray.count-1) {
                        
//                        NSDictionary *dict = @{@"userid":userid,@"title":title,@"describe":describe,@"slogan":slogan,@"minamount":minamount,@"endtime":endtime,@"cover":coverkey,@"mediatype":@(mediatype),@"dreamtype":@" ",@"medialist":photoKey,@"lablelist":lablelist};
                        
                        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",title,@"title",describe,@"describe",slogan,@"slogan",minamount,@"minamount",endtime,@"endtime",coverkey,@"cover",@(mediatype),@"mediatype",@"",@"dreamtype",photoKey,@"medialist",lablelist,@"lablelist", nil];
                        //发布梦想
                        [RequestEngine UserModulescollegeWithDict:dict wAction:@"520" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                            
                            if (completed) {
                                
                                completed(errorCode,nil);
                            }
                        }];
                    }
                    return nil;
                }];
            }
        }
        //上传视频
        else if (mediatype == 2)
        {
            NSString *videoKey = [BaseViewController getOSSObjectKeyWithtype:@"mp4"];
            NSLog(@"%@",videoKey);
            NSData *data = [NSData dataWithContentsOfFile:Videopath];
            [OSSHelper uploadVideoObjectWithKey:videoKey data:data type:1 progress:nil success:^id(OSSTask *taskVideo) {
                
//                NSDictionary *dict = @{@"userid":userid,@"title":title,@"describe":describe,@"slogan":slogan,@"minamount":minamount,@"endtime":endtime,@"cover":coverkey,@"mediatype":@(mediatype),@"dreamtype":@" ",@"medialist":videoKey,@"lablelist":lablelist};
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",title,@"title",describe,@"describe",slogan,@"slogan",minamount,@"minamount",endtime,@"endtime",coverkey,@"cover",@(mediatype),@"mediatype",@"",@"dreamtype",videoKey,@"medialist",lablelist,@"lablelist", nil];
                //发布梦想
                [RequestEngine UserModulescollegeWithDict:dict wAction:@"520" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                    
                    if (completed) {
                        
                        completed(errorCode,nil);
                    }
                }];
                
                return nil;
            }];
        }
        return nil;
    }];
}


#pragma mark -发布梦想轨迹轨迹
- (void)Releasedreamtrajectory:(NSString *)dreamid Andmediatype:(int)mediatype Andbatch:(int)batch AndPhotoArray:(NSArray *)photoarray AndVideo:(NSString *)VideoPah Completed:(void(^)(NSString * errorCode, NSString*resultDict))completed
{
    [OSSLog enableLog];
    //上传图片
    if (mediatype == 1) {
        
        NSMutableArray *keyarray = [NSMutableArray array];
        for (int i=0; i<photoarray.count; i++) {
            [keyarray addObject:[BaseViewController getOSSObjectKeyWithtype:@"png" index:i]];
        }
        NSString *photoKey = [keyarray componentsJoinedByString:@","];//图片key
        NSArray *imagearr;
        if (keyarray.count > 6) {
            
            NSRange rang = NSMakeRange(keyarray.count-6, keyarray.count);
            imagearr = [keyarray subarrayWithRange: rang];
        }else
        {
            imagearr = [NSArray arrayWithArray:keyarray];
        }
        for (int i=0; i<imagearr.count; i++) {
            
        
            [OSSHelper uploadImageObjectWithKey:[keyarray objectAtQYQIndex:i] data:UIImageJPEGRepresentation([photoarray objectAtQYQIndex:i], 0.0001) type:1 progress:nil success:^id(OSSTask *taskPhoto) {
                
                if (i == photoarray.count-1) {
                    
//                    NSDictionary *dict = @{@"medialist":photoKey,@"dreamid":dreamid,@"mediatype":@(mediatype),@"batch":@(batch)};
                    
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:photoKey,@"medialist",dreamid,@"dreamid",@(mediatype),@"mediatype",@(batch),@"batch", nil];
                    
                    //发布梦想
                    [RequestEngine UserModulescollegeWithDict:dict wAction:@"501" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                        
                        if (completed) {
                            
                            completed(errorCode,nil);
                        }
                    }];
                }
                return nil;
            }];
        }
    }
    //上传视频
    else if (mediatype == 2)
    {
         NSString *videoKey = [BaseViewController getOSSObjectKeyWithtype:@"mp4"];
        [OSSHelper uploadVideoObjectWithKey:videoKey data:[NSData dataWithContentsOfFile:VideoPah] type:1 progress:nil success:^id(OSSTask *taskVideo) {
            
//            NSDictionary *dict = @{@"medialist":videoKey,@"dreamid":dreamid,@"mediatype":@(mediatype),@"batch":@(batch)};
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:videoKey,@"medialist",dreamid,@"dreamid",@(mediatype),@"mediatype",@(batch),@"batch", nil];
            //发布梦想
            [RequestEngine UserModulescollegeWithDict:dict wAction:@"501" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                
                if (completed) {
                    
                    completed(errorCode,nil);
                }
            }];
            
            return nil;
        }];
    }
    
}




































@end
