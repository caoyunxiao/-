//
//  QYQButton.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/12.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "QYQButton.h"

#define HMImageRadio 0.7
#define HMMargin 6
@implementation QYQButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        //[self.imageView sizeToFit];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:kColor(136, 130, 128) forState:UIControlStateNormal];
        [self setTitleColor:kColor(216, 0, 104) forState:UIControlStateSelected];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width;
    CGFloat btnH = self.height;
    CGFloat imageH = btnH * HMImageRadio;
    self.imageView.frame = CGRectMake(0, 0, btnW, imageH);
    
    CGFloat titleH = btnH - imageH;
    CGFloat titleY = imageH - 2;
    self.titleLabel.frame = CGRectMake(0, titleY, btnW, titleH);
    
    
}

- (void)setHighlighted:(BOOL)highlighted{}
@end
