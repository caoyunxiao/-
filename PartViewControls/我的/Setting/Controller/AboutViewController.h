//
//  AboutViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutViewController : BaseViewController
/**
 *  背景滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollerView;
/**
 *  返回设置页面
 */
@property (weak, nonatomic) IBOutlet UIButton *backSetting;

@property (weak, nonatomic) IBOutlet UILabel *versonLabel;

@end
