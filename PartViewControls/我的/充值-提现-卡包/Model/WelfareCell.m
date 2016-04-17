//
//  WelfareCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/18.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "WelfareCell.h"
#import "UIImageView+WebCache.h"     //下载图片的分类

@implementation WelfareCell

- (void)awakeFromNib {
    // Initialization code
    
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configImageWithIndexpath:(NSIndexPath *)indexpath
{
   
    if (indexpath.row == 0) {
        self.bgImageView.image = [UIImage imageNamed:@"wuxinghuodong .png"];
    }
    else
    {
        self.bgImageView.image = [UIImage imageNamed:@"RMhuodong.png"];
    }
    
}
@end
