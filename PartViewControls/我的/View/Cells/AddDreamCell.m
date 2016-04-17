//
//  AddDreamCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/26.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "AddDreamCell.h"

@implementation AddDreamCell

- (void)awakeFromNib {
    // Initialization code
    [self.addLabel setMyCorner];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
