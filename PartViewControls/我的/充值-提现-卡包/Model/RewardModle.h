//
//  RewardModle.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/20.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /***打赏订单的模型**/

#import <Foundation/Foundation.h>

@interface RewardModle : NSObject
/*
 amount = 1000;
 beRewardUid = 3;
 createTime = "/Date(1448436684133+0800)/";
 dreamID = 74;
 headImg = None;
 nickName = "\U6211\U60f3\U4f60\U8bf4";
 rewardID = 2358;
 rewardUid = 3282;
 state = 0;
 userID = 0;
 */
/**
*  打赏金额
*/
@property (nonatomic, copy) NSString *amount;
/**
 *  被打赏的UID
 */
@property (nonatomic, copy) NSString *beRewardUid;
/**
 *  打赏时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 *  打赏头像
 */
@property (nonatomic, copy) NSString *headImg;
/**
 *  打赏昵称
 */
@property (nonatomic, copy) NSString *nickName;


@end
