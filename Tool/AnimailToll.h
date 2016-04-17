//
//  AnimailToll.h
//  他个头高投入
//
//  Created by qiuyaqingMac on 15/12/3.
//  Copyright © 2015年 TC. All rights reserved.
//  /*显示打赏动画的和弹幕*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimailToll : NSObject



/**
 *  <#Description#>
 *
 *  @param view      动画要加到的父视图
 *  @param imageName 图片的名字
 */
+ (void)showRewordanimation:(UIView *)view imageName:(NSString *)imageName landscape:(BOOL)landscape;
@end
