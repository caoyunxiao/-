//
//  ReceiveGoodsCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ReceiveGoodsCell.h"

@implementation ReceiveGoodsCell

- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configModel:(AddressModle *)model
{
    self.nameLabel.text = model.name;
    self.mobileLabel.text = model.mobile;
    self.addrLabel.text = model.addr;
}
@end
