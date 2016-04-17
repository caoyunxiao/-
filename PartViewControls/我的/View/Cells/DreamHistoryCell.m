//
//  DreamHistoryCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "DreamHistoryCell.h"

@implementation DreamHistoryCell

- (void)awakeFromNib {

    self.stateBtn.layer.cornerRadius = self.stateBtn.width/5;
    self.stateBtn.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configData:(HomeModel *)model
{
   // NSLog(@"模型%@",model.state);

    self.nameLabel.text = model.name.description;
    self.timeLabel.text = model.createTime.description;
    
    if ([model.state.description isEqualToString:@"1"]) {
        
        self.stateBtn.backgroundColor = [UIColor greenColor];
        
          [self.stateBtn setTitle:@"进行中" forState:UIControlStateNormal];
    }
    if ([model.state.description isEqualToString:@"2"]) {
        
          self.stateBtn.backgroundColor = TCColor;
         [self.stateBtn setTitle:@"成功" forState:UIControlStateNormal];
        
    }
    if ([model.state.description isEqualToString:@"3"]) {
        
        self.stateBtn.backgroundColor = TCColordefault;
        
        [self.stateBtn setTitle:@"失败" forState:UIControlStateNormal]; //= @"";
    
    }
    if ([model.state.description isEqualToString:@"4"]) {
        self.stateBtn.backgroundColor = TCColordefault;
        [self.stateBtn setTitle:@"驳回" forState:UIControlStateNormal];
    }
    if ([model.state.description isEqualToString:@"5"]) {
        self.stateBtn.backgroundColor = TCColordefault;
        [self.stateBtn setTitle:@"用户关闭" forState:UIControlStateNormal];
    }
//    else
//    {
//        [self.stateBtn setTitle:@"未知" forState:UIControlStateNormal];
//    }
    
}
@end
