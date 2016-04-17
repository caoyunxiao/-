//
//  PublishedPhotosViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface PublishedPhotosViewController : BaseViewController{
    NSInteger _indexImage;

    NSMutableArray *_newImageArray;
    
    BOOL _isCoverImage;
    
    NSString *_title;//梦想标题
    
    NSString *_describeStr;//梦想描述
    
    NSString *_slogan;//拉赞口号
    
    NSInteger _photoCount;//照片数量
    
    NSString *_medialist;//视频图片列表 英文逗号分隔
    
    NSString *_lablelist;//梦想标签列表 英文逗号分隔
    
    NSString *_endtime;//梦想截止日期
    
    NSString *_minamount;//最少达成金额
    
    NSString *_coverStr;//梦想封面照
    
    NSString *_mediatype;//媒体类型1图2视频
    
    NSMutableArray *_lablelistArr;//标签
    
    NSMutableArray *_upLoadResultArr;//上传结果
    
    UIImage *_homePagePic;             //封面照片
    
}

@property (nonatomic,strong) NSArray *imageArray;//照片数组

@property (nonatomic,copy) NSString *resourceType;//photo  video

@property (nonatomic,copy) NSURL *videoFileURL;//视频URL
@property (nonatomic,copy) NSString *VideoString; //视频路径
@end
