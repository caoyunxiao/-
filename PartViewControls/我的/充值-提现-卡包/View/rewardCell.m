//
//  rewardCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/12.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "rewardCell.h"

@implementation rewardCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configModle:(RewardModle *)model
{
    self.timeLabel.text = [BaseViewController getTimerStrFromSever:model.createTime];
    self.nameLabel.text = model.nickName;
    
    self.kabeiLabel.text = [NSString stringWithFormat:@"-%@咖贝",model.amount.description];
    
}
@end
