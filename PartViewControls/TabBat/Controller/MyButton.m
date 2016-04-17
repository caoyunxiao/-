//
//  MyButton.m
//  Caoyunxiao
//
//  Created by 曹云霄 on 15/12/28.
//  Copyright © 2015年 曹云霄. All rights reserved.
//

#import "MyButton.h"

#define Width [UIScreen mainScreen].bounds.size.width

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (_indexButton == 2) {
        
        return CGRectMake(Width/5-Width/5+((Width/5-30)/2), 3, 30, 30);
    }
    return CGRectMake(Width/5-Width/5+((Width/5-18)/2), 16, 18, 18);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (_indexButton == 2) {
        
        return CGRectMake(Width/5-Width/5, 42, Width/5, 10);
    }
    return CGRectMake(Width/5-Width/5, 42, Width/5, 10);
}



@end
