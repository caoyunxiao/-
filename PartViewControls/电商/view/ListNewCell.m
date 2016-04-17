//
//  ListNewCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ListNewCell.h"
#import "ZNControl.h"
#import "UIImageView+WebCache.h"               //图片缓存

@implementation ListNewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.ListNewClass.layer.masksToBounds = YES;
    self.ListNewClass.layer.cornerRadius = 5;
    self.ListNewClass.layer.borderColor = [UIColor whiteColor].CGColor;
    self.ListNewClass.layer.borderWidth = 1.0;
    
}
- (void)showUIViewWithModel:(OnlineModel *)model
{
    NSString *color = model.color;
    if(![color isEqual:[NSNull null]]&&color.length!=0)
    {
        self.backgroundColor = [ZNControl convertHexadecimalColor:model.color];
    }
    else
    {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    self.ListTitle.text = model.name;
    self.ListDescribe.text = model.discription;
    self.ListNewClass.text = model.style;
    self.ListNewprice.text = [NSString stringWithFormat:@"%@",model.price];
    
    self.kabeiLabel.text = model.caBei.description;
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
