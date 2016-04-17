//
//  TaskCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/31.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell

- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configData:(TaskModel *)model
{
    
    NSLog(@"configData:(TaskModel *)model");
    NSString *rewardStr = [NSString stringWithFormat:@"%@咖贝",model.reward];
    self.rewardLabel.text = rewardStr;
    self.myTitleLabel.text = model.name;
    self.type = model.type;
    
    if ([model.hasDone isEqualToString:@"0"]) {
        
        self.finish.selected = NO;
    }
    else
    {
        self.finish.selected = YES;
    }
}
- (void)configDataWithThreeCell:(TaskModel *)model
{
    self.titleLabel.text = model.name;
}
@end
