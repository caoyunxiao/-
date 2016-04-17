//
//  BuyDownView.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BuyDownView.h"
#import "UIImageView+WebCache.h"

@implementation BuyDownView

- (void)awakeFromNib {
    // Initialization code
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//点击确认的按钮
- (IBAction)sureBtnClick:(UIButton *)sender {
    
}

- (void)configModel:(OnlineModel *)model
{
    [self.buyImageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
    self.buyPrice.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.kabeiLabel.text = model.caBei;
    self.buyName.text = model.name;
    self.buyClass.text = model.style;
    
    
}
@end
