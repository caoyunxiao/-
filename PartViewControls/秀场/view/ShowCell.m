//
//  ShowCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/9/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ShowCell.h"

@implementation ShowCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showUIViewWithModelForNew:(HomeModel *)model
{
    self.SCName.text = model.name;
    self.SCDiscription.text = model.slogan;
//    NSString *amountStr = [NSString stringWithFormat:@"%@咖贝",model.minimumValue];
//    if ([model.minimumValue floatValue]>=10000)
//    {
//        amountStr = [NSString stringWithFormat:@"%dW咖贝",(int)[amountStr floatValue]/10000];
//    }
    self.SCKaBei.text = [NSString stringWithFormat:@"%@",model.minimumValue];
    [self.SCImageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
    self.SCImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.SCImageView.clipsToBounds = YES;
    
    NSArray *picVidArray = model.picVid;
    NSDictionary *dict = [picVidArray firstObject];
    if ([dict[@"Type"] integerValue] == 2) {
        
        for (UIView *view in self.SCImageView.subviews) {
            
            if ([view isKindOfClass:[UIButton class]]) {
                
                [view removeFromSuperview];
            }
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 60);
        button.center = CGPointMake(ScreenWidth/2, self.SCImageView.bounds.size.height/2);
        [button setImage:[UIImage imageNamed:@"playvideo"] forState:UIControlStateNormal];
        [self.SCImageView addSubview:button];
    }
    else if([dict[@"Type"] integerValue] == 1)
    {
        for (UIView *view in self.SCImageView.subviews) {
            
            if ([view isKindOfClass:[UIButton class]]) {
                
                [view removeFromSuperview];
            }
        }
    }
    //打赏集合
    NSArray *dreamRewardArr = model.dreamReward;
    NSInteger hasDown = 0;
    for (NSDictionary *dict in dreamRewardArr)
    {
        NSInteger amount = [dict[@"amount"] integerValue];
        hasDown += amount;
    }
    _setProgress = [[UCZProgressView alloc]initWithFrame:self.SCTwoVIew.bounds];
    [self.SCTwoVIew addSubview:_setProgress];
    _setProgress.showsText = YES;
    _setProgress.radius = self.SCTwoVIew.bounds.size.width/2-5;
    _setProgress.tintColor = [UIColor colorWithRed:210/255.0 green:0 blue:104/255.0 alpha:1.0];
    [_setProgress setProgress:[model.raisePercent floatValue] animated:NO];
    
}


@end
