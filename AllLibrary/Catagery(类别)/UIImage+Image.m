//
//  UIImage+Image.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)


+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
