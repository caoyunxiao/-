//
//  InviteFriendViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /****邀请好友页面***/

#import "BaseViewController.h"

@interface InviteFriendViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tbView;

/**
 *  我的邀请码
 */
@property (weak, nonatomic) IBOutlet UILabel *myInvientNumber;

@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;

/**
 *  立即邀请好友
 *
 *  @param sender sender
 */
- (IBAction)OnceInviteBtnClick:(UIButton *)sender;
/*brthbrthbrt*/
@end
