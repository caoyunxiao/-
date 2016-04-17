//
//  dreamRewardModel.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/27.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dreamRewardModel : NSObject

/// 梦想打赏
@property (nonatomic,copy) NSString *rewardID;   //打赏ID
@property (nonatomic,copy) NSString *rewardUid;   //打赏人ID
@property (nonatomic,copy) NSString *nickName;   // 打赏人昵称
@property (nonatomic,copy) NSString *dreamID;   //被打赏梦想ID
@property (nonatomic,copy) NSString *beRewardUid;   //被打赏用户ID
@property (nonatomic,copy) NSString *amount;   //打赏咖呗数量
@property (nonatomic,copy) NSString *createTime;   //打赏时间
@property (nonatomic,copy) NSString *headImg;//头像

@end
