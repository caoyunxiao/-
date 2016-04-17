//
//  RightDownView.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/20.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "RightDownView.h"

@implementation RightDownView

- (void)awakeFromNib {
    // Initialization code
    self.RDView.layer.masksToBounds = YES;
    self.RDView.layer.cornerRadius = 130;
    
    self.labelArr = [[NSMutableArray alloc]init];
    self.DanMuView.clipsToBounds = YES;
    self.isShow = YES;
    

//    _titltArr = @[@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V",@"弹幕123456687899",@"阿双方深V各方vrsgvve",@"dcacdzsv从DVD深V"];
    //int x = arc4random() % _titltArr.count;
}



#pragma mark -数据源
- (void)setTitltArr:(NSArray *)titltArr
{
    for (int i = 0; i<_titltArr.count; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, self.DanMuView.frame.origin.y+2 + 22*i, 144, 20)];
        [self.DanMuView addSubview:label];
//        label.text = _titltArr[i];
        
        label.text = [_titltArr objectAtQYQIndex:i];
        

        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [self.labelArr addObject:label];
    }
    if(self.labelArr.count>0)
    {
        [_timer setFireDate:[NSDate distantPast]];
    }
    
    //先创建
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(danmuMove) userInfo:nil repeats:YES];
}


- (void)danmuMove
{
    for (int i = 0; i<_labelArr.count; i++)
    {
        UILabel *label = [_labelArr objectAtQYQIndex:i];
        CGRect frame = label.frame;
        if(frame.origin.y<=-22)
        {
            [label removeFromSuperview];
            [self.labelArr removeObjectAtIndex:i];
        }
        else
        {
            frame.origin.y = frame.origin.y - 2;
            label.frame = frame;
        }
    }
    if(self.labelArr.count<=0)
    {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

#pragma mark - 开启关闭弹幕
- (IBAction)DanMuViewClick:(UIButton *)sender {
    if(self.isShow)
    {
        self.DanMuView.hidden = YES;
    }
    else
    {
        self.DanMuView.hidden = NO;
    }
    self.isShow = !self.isShow;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
