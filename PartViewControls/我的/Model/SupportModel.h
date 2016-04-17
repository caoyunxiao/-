//
//  SupportModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /**支持梦想的模型**/

#import <Foundation/Foundation.h>

@interface SupportModel : NSObject
/* amount = 5;
 beRewardUid = 0;
 createTime = "/Date(1448143678113+0800)/";
 dreamID = 0;
 headImg = "";
 nickName = "\U66f9\U4e91\U9704";
 rewardID = 0;
 rewardUid = 0;
 state = 0;
 userID = 3266;*/
/**
*  支持的金额
*/
@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *beRewardUid;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *dreamID;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *rewardID;
@property (nonatomic, copy) NSString *rewardUid;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *userID;
@end
