//
//  TCHomeCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/9/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TCHomeCell.h"

@implementation TCHomeCell


- (void)setModel:(HomeModel *)model
{
    _model = model;
    NSArray *arrAy = _model.picVid;
    NSDictionary *dict = [arrAy firstObject];
    if (arrAy.count >= 1 && [dict[@"Type"] integerValue] == 1) {
        
        
        self.name.frame = CGRectMake(0,self.frame.size.height/2, ScreenWidth, 35);
        for (UIView *VIEW in self.TCImageView.subviews) {
            
            if ([VIEW isKindOfClass:[UIButton class]]) {
                
                [VIEW removeFromSuperview];
            }
        }
    }
    else
    {
        for (UIView *VIEW in self.TCImageView.subviews) {
            if ([VIEW isKindOfClass:[UIButton class]]) {
                
                [VIEW removeFromSuperview];
            }
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 60);
        button.center = CGPointMake(ScreenWidth/2, self.frame.size.height/2);
        [button setImage:[UIImage imageNamed:@"playvideo"] forState:UIControlStateNormal];
        [self.TCImageView addSubview:button];
        self.name.frame = CGRectMake(0, button.frame.origin.y+80, ScreenWidth, 35);
        
    }
    
    [self.TCImageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
    self.TCImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.TCImageView.clipsToBounds = YES;
    self.name.text = model.name;
    self.name.textColor = [UIColor whiteColor];
    self.name.font = [UIFont boldSystemFontOfSize:22];
    self.name.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.name.textAlignment = NSTextAlignmentCenter;
}



#pragma mark - 动态获取文本高度
- (CGRect)dynamicHeight:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:20];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(ScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







@end




