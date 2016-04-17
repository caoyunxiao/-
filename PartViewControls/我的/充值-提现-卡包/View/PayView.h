//
//  PayView.h
//  payView
//
//  Created by 329463417 on 15/10/19.
//  Copyright (c) 2015年 329463417. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "payPopupView.h"



@interface PayView : UIView<payPopupViewDelegate>

/**
 *  底部支付视图
 */
@property (nonatomic, strong) payPopupView *payPopupView;


- (void)dismiss:(UITapGestureRecognizer *)tap;

- (void)show;
@end
