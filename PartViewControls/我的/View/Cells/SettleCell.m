//
//  SettleCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SettleCell.h"
#import "UIImageView+WebCache.h"

@implementation SettleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configModel:(OnlineModel *)model
{
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
   
    self.goodsDescLabel.text = model.name;
    
    self.priceLabel.text = model.price.description;
    
    self.kabeiLabel.text = model.caBei.description;
    
    self.goodsStyleLabel.text = model.style;
    
    self.goosCountLabel.text = model.total.description;
}

@end
