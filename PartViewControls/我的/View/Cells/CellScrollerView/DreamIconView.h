//
//  DreamIconView.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/14.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义一个无返回值，无参数的Block
typedef void(^ShowIconOption)();

@interface DreamIconView : UIView
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *iconIamgeView;
/**
 *  名字
 */
@property (nonatomic, strong) UILabel *nameLabel;
/**
 *  支持金额
 */
@property (nonatomic, strong) UILabel *suppotrCountLabel;
/**
 *  block 回调
 */
@property (nonatomic, copy) ShowIconOption option;
@end
