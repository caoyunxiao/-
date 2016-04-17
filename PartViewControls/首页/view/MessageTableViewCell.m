//
//  MessageTableViewCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/11/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(leaveWordsModel *)model
{
    
    self.MessagebackView.layer.masksToBounds = YES;
    self.MessagebackView.layer.cornerRadius = (model.Contentsize.width == ScreenWidth)?15:5;
    self.PersonName.text = model.nickName;
    self.PersonMessage.text = [NSString stringWithFormat:@"%@",model.content];
    self.MessagebackView.frame = CGRectMake(self.MessagebackView.frame.origin.x, self.MessagebackView.frame.origin.y, model.Contentsize.width+20, model.Contentsize.height);
    self.PersonMessage.frame = CGRectMake(self.PersonMessage.frame.origin.x, self.PersonMessage.frame.origin.y, model.Contentsize.width,model.Contentsize.height);
    
}

@end
