//
//  UIImageView+LoadDataZFJ.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIImageView (LoadDataZFJ)


//通过阿里云的OSS的ObjectKey加载图片，并实现图片缓存
- (void)setImageWithObjectKey:(NSString *)ObjectKey placeholderImage:(UIImage *)placeholder;

//通过url加载图片，并实现永久缓存
- (void)setImageWithURLOfZFJ:(NSString *)url placeholderImage:(UIImage *)placeholder;


@end
