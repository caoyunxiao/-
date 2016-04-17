//
//  ShoppingCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ShoppingCell.h"
#import "UIImageView+WebCache.h"             //请求网络数据

@implementation ShoppingCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (IBAction)selectBTnClick:(UIButton *)sender {
//    
//    sender.selected =!sender.selected;
//    
//}

- (void)configModel:(OnlineModel *)model
{
    
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
    self.goodsDescLabel.text = model.name;
    
    self.priceLabel.text = model.price.description;
    
    self.kabeiLabel.text = model.caBei.description;

    self.goodsStyleLabel.text = model.style;
    
    self.goosCountLabel.text = model.total.description;
    
    self.selectBtn.selected = model.selected;
    
    
}

@end
