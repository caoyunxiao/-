//
//  ReleaseRreamsCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ReleaseRreamsCell.h"

@implementation ReleaseRreamsCell

- (void)awakeFromNib
{
    self.RDreamsDescribe.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    self.RDreamsDescribe.layer.borderWidth = 1.0;
}

//设置UI
- (void)showUIViewWithImageArr:(NSArray *)showArr
{
    for (UIView *view in self.subviews)
    {
        if([view isKindOfClass:[UIImageView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    NSInteger width = (ScreenWidth-40)/4;
    for (int i = 0; i<showArr.count; i++)
    {
        UIImageView *image = [[UIImageView alloc]init];
        image.frame = CGRectMake((width + 8)*(i%4), (width+8)*(i/4), width, width);
        image.image = [showArr objectAtQYQIndex:i];
        [self.RDreamsShow addSubview:image];
    }
    NSInteger a = showArr.count;
    self.RDreamsAddImage.frame = CGRectMake((width + 8)*(a%4), (width+8)*(a/4), width, width);
    
    CGRect frame = self.RDreamsShow.frame;
    NSInteger q1 = (showArr.count+1)/4;
    NSInteger q2 = (showArr.count+1)%4;
    if(q2 != 0)
    {
        q1++;
    }
    CGFloat height;
    if(q1<=3)
    {
        height = q1*(width + 8);
    }
    else
    {
        height = 3*(width + 8);
    }
    self.RDreamsShow.frame = CGRectMake(frame.origin.x, frame.origin.y, ScreenWidth-16, height);
    
    NSInteger RDreamsLabel_Y = self.RDreamsShow.frame.origin.y+self.RDreamsShow.frame.size.height+8;
    self.RDreamsLabel.frame = CGRectMake(8, RDreamsLabel_Y, self.frame.size.width-16, 35);
    
    self.RDreamsShow.contentSize = CGSizeMake(self.frame.size.width-16, q1*(width + 8));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
