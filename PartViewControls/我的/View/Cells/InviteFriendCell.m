//
//  InviteFriendCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/17.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "InviteFriendCell.h"

@implementation InviteFriendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configModle:(InviteFriendModle *)model
{
    
    if (model.userName.length >0) {
        
        NSMutableString *string1 = [[NSMutableString alloc] initWithString:model.userName];
        [string1 replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.userNameLabel.text = string1;
    }
    
   
    
    self.timeLabel.text = model.regTime;
    
}
@end
