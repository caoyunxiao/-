//
//  DreamIconView.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/14.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "DreamIconView.h"

@implementation DreamIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _iconIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 2, self.width -2, self.width -2)];
        //创建头像
        _iconIamgeView.layer.borderWidth = 0.3;
        [_iconIamgeView.layer setCornerRadius:_iconIamgeView.height/2];
        _iconIamgeView.layer.shouldRasterize = YES;
        _iconIamgeView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [_iconIamgeView.layer setMasksToBounds:YES];
        _iconIamgeView.layer.borderColor = TCColordefault.CGColor;
        _iconIamgeView.contentMode = UIViewContentModeScaleAspectFill;
        _iconIamgeView.clipsToBounds = YES;
        [self addSubview:_iconIamgeView];
        
        //创建昵称
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(_iconIamgeView.bounds)+2, self.width -2, 10)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = [UIFont systemFontOfSize:8];
        
        [_nameLabel setTextColor:TCColordefault];
        
        [self addSubview:_nameLabel];
        
        //创建支持的数量
        _suppotrCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, (_nameLabel.height +_nameLabel.y), self.width-2, 10)];
        
        _suppotrCountLabel.textAlignment = NSTextAlignmentCenter;
        
        _suppotrCountLabel.font = [UIFont systemFontOfSize:8];
        
        [_suppotrCountLabel setTextColor:TCColordefault];
        
        [self addSubview:_suppotrCountLabel];
        
        //为自己添加一个手势
        UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:tab];

    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
    
    self.option();

    
}
@end
