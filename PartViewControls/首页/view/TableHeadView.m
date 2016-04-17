//
//  TableHeadView.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/12.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TableHeadView.h"

@implementation TableHeadView

- (void)awakeFromNib {
    // Initialization code
    self.HeadImage.layer.masksToBounds = YES;
    self.HeadImage.layer.cornerRadius = 40;
    self.HeadImage.layer.borderWidth = 2.0;
    self.HeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.HeadRightView.layer.masksToBounds = YES;
    self.HeadRightView.layer.cornerRadius = 25;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
