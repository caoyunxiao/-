//
//  ShoppingButtomCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /***************************一个空的Cell用来占据购物车底部的位置*********************/

#import "ShoppingButtomCell.h"

@implementation ShoppingButtomCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
