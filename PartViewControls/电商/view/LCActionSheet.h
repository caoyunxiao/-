//
//  Created by 刘超 on 15/4/26.
//  Copyright (c) 2015年 Leo. All rights reserved.
//
//  Email:  leoios@sina.com
//  GitHub: http://github.com/LeoiOS
//  如有问题或建议请给我发Email, 或在该项目的GitHub主页lssues我, 谢谢:)
//

#import <UIKit/UIKit.h>


@class LCActionSheet;

@protocol LCActionSheetDelegate <NSObject>

@optional



@end

@interface LCActionSheet : UIView

@property (nonatomic, strong) UIView *buyDownView;
/**
 *  <#Description#>
 */
- (void)dismiss;

- (void)show;

- (instancetype)initWithView:(UIView *)buydownView;

@end
