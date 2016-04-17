//
//  ExceptionalListCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ExceptionalListCell.h"

@implementation ExceptionalListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showUIViewWith:(dreamRewardModel *)model
{
    NSString *amountStr = [NSString stringWithFormat:@"%@咖贝",model.amount];
    if ([amountStr floatValue]>=10000)
    {
        amountStr = [NSString stringWithFormat:@"%.2fW咖贝",[amountStr floatValue]/10000];
    }
    self.nickName.text = model.nickName;
    self.amount.text = amountStr;
    self.timeLabel.text = model.createTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
