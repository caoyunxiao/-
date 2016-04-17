//
//  CosFundForVideoCYX.h
//  CosFund
//
//  Created by 曹云霄 on 15/12/4.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CosFundForVideoCYX : NSObject


+ (CosFundForVideoCYX *)manager;

#pragma mark -发布梦想
/*
 *coverurl :封面URL
 *boolForDream:是否是视频
 *photoArray:图片数组
 *VideoURL:视频URL
 
 */
- (void)Releasedreamscover:(UIImage *)coverpath Andmediatype:(int)mediatype Anduserid:(NSString *)userid Andtitle:(NSString *)title Anddescribe:(NSString *)describe Andslogan:(NSString *)slogan Andminamount:(NSString *)minamount Andendtime:(NSString *)endtime Andlablelist:(NSString *)lablelist AndphotoArray:(NSArray *)photoArray orVideopath:(NSString *)Videopath Completed:(void(^)(NSString * errorCode, NSString*resultDict))completed;

#pragma mark -发布梦想轨迹轨迹
- (void)Releasedreamtrajectory:(NSString *)dreamid Andmediatype:(int)mediatype Andbatch:(int)batch AndPhotoArray:(NSArray *)photoarray AndVideo:(NSString *)VideoPah Completed:(void(^)(NSString * errorCode, NSString*resultDict))completed;


@end
