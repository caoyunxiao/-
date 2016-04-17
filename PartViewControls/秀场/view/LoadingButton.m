//
//  LoadingButton.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/11/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "LoadingButton.h"

@implementation LoadingButton

- (void)awakeFromNib {
    // Initialization code
    self.clipsToBounds = YES;
    
//    _imageArr = [[NSMutableArray alloc]init];
//    CGFloat width = 30;
//    
//    for (int i = 0; i<3; i++)
//    {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -width+width*i, width, width)];
//        [self.myLoadView addSubview:imageView];
//        imageView.backgroundColor = [UIColor blackColor];
//        imageView.image = [UIImage imageNamed:@"loadImage"];
//        [_imageArr addObject:imageView];
//    }
//    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(moveImage) userInfo:nil repeats:YES];
//    [timer setFireDate:[NSDate distantPast]];
    
    self.pathViewFailure =[[GifView alloc] initWithFrame:CGRectMake(0, 0, 40, 35) filePath:[[NSBundle mainBundle] pathForResource:@"loadingImage" ofType:@"gif"]];
    [self.myLoadView addSubview:self.pathViewFailure];
    
}

- (void)moveImage
{
    for (int i = 0; i<_imageArr.count; i++)
    {
        UIImageView *view = [_imageArr objectAtQYQIndex:i];
        CGRect frame = view.frame;
        if(frame.origin.y>=-30&&frame.origin.y<=30)
        {
            frame.origin.y = frame.origin.y + 10;
            view.frame = frame;
        }
        else
        {
            [view removeFromSuperview];
        }
    }
    if(_imageArr.count<3)
    {
        UIImageView *lastView = [_imageArr lastObject];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, lastView.frame.size.height+lastView.frame.origin.y, 30, 30)];
        [self.myLoadView addSubview:imageView];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.image = [UIImage imageNamed:@"loadImage"];
        [_imageArr addObject:imageView];
    }
    
    NSLog(@"_imageArr = %ld",(long)_imageArr.count);
}

@end
