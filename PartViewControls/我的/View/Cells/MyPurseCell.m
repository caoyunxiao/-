//
//  MyPurseCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "MyPurseCell.h"
       //请求钱包数据

@implementation MyPurseCell


#pragma mark - 请求服务其数据

- (void)awakeFromNib {

    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)rechargeBtnClick:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(MyPurseCellRechargeDidClick)]) {
        [_delegate MyPurseCellRechargeDidClick];
    }
    
}

- (IBAction)kabaoBtnClick:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(MyPurseCellkabaoBtnClick)]) {
        [_delegate MyPurseCellkabaoBtnClick];
    }

}

- (IBAction)myCheck:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(MyPurseCellMyCheckBtnClick)]) {
        [_delegate MyPurseCellMyCheckBtnClick];
        
    }
    
    
}
@end
