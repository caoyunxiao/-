//
//  UIImage+Image.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  ***************加载最原始的图片，没有渲染********************

#import <UIKit/UIKit.h>

@interface UIImage (Image)


//加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
@end
