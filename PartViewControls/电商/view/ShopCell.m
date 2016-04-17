//
//  ShopCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/9/25.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (void)awakeFromNib {
    // Initialization code
}

//展示排列上部数据
- (void)showTopUIViewWithArray:(NSArray *)array
{
    NSInteger height = ScreenWidth/2;
    //刚好
    if(array.count%2==0)
    {
        for(int a=0;a<array.count;a++)
        {
            UIImageView *image = [[UIImageView alloc]init];
            image.frame = CGRectMake(height*(a%2), height*(a/2), height, height);
            image.image = [UIImage imageNamed:array[a]];
            [self addSubview:image];
            image.userInteractionEnabled = YES;
            image.tag = 60+a;
            
            //UIGestureRecognizer
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [image addGestureRecognizer:tap];
        }
    }
    //多一个
    else
    {
        for(int a=0;a<array.count-1;a++)
        {
            UIImageView *image = [[UIImageView alloc]init];
            image.frame = CGRectMake(height*(a%2), height*(a/2), height, height);
            image.image = [UIImage imageNamed:array[a]];
            [self addSubview:image];
            image.userInteractionEnabled = YES;
            image.tag = 60+a;
            
            //UIGestureRecognizer
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [image addGestureRecognizer:tap];
        }
        UIImageView *lastImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, height*(array.count/2), ScreenWidth, height)];
        lastImage.tag = 60+array.count-1;
        lastImage.image = [UIImage imageNamed:array.lastObject];
        [self addSubview:lastImage];
        lastImage.userInteractionEnabled = YES;
        
        //UIGestureRecognizer
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [lastImage addGestureRecognizer:tap];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)tap
{
    if([self.delegate respondsToSelector:@selector(selectOneImageByClick:)])
    {
        [self.delegate selectOneImageByClick:tap.view.tag];
    }
}

//显示下排数据
- (void)showUIViewDownWithString:(NSString *)str
{
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.frame];
    [self addSubview:image];
    image.image = [UIImage imageNamed:str];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [image addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
