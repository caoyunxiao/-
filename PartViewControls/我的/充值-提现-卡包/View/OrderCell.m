//
//  OrderCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)config:(OrederModel *)modle
{
    if ([modle.ctid.description isEqualToString:@"10"]) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@人民币",modle.totalPrice.description];
        
    }
    else{
        self.nameLabel.text = [NSString stringWithFormat:@"%@咖贝",modle.totalPrice.description];
    }
    
    self.timeLabel.text = [BaseViewController getTimerStrFromSever:modle.createTime];
    
    self.IDLabel.text = modle.orderSN.description;

}
@end
