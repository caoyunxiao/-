//
//  InviteFriendCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/17.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteFriendModle.h"

@interface InviteFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


- (void)configModle:(InviteFriendModle *)model;
@end
