//
//  ExchargeCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ExchargeCell.h"

@implementation ExchargeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configModle:(ExchangeModle *)model
{
    
    self.timeLabel.text =[BaseViewController getTimerStrFromSever:model.exchangeTime];
    
    self.exchgeKabeiLable.text = [NSString stringWithFormat:@"%@元",model.amount];
    
}
@end
