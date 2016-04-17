//
//  HomeModel.h
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeModel : NSObject
/*
 cover = "151211619641448086723.png";
 createTime = "/Date(1448086811940+0800)/";
 describe = "\U4ec0\U4e48\U60c5\U51b5";
 dreamID = 76;
 dreamLable =         (
 );
 dreamReward =         (
 );
 dreamType =         (
 );
 endDate = "/Date(1448432349000+0800)/";
 homepage = 0;
 isCollect = 0;
 leaveWords =         (
 );
 minimumValue = 30000000;
 name = "\U66f9\U4e91\U9704";
 picVid =         (
 );
 settlementStatus = 0;
 slogan = "\U4ec0\U4e48\U60c5\U51b5";
 sorting = 0;
 state = 1;
 userID = 3266;
 */
/// 梦想
@property (nonatomic,copy) NSString *createTime;   //创建时间
@property (nonatomic,copy) NSString *createUser;   //创建人
@property (nonatomic,copy) NSString *describe;     //梦想描述
@property (nonatomic,copy) NSString *dreamID;      //梦想ID
@property (nonatomic,strong) NSArray *dreamLable;  //梦想标签
@property (nonatomic,copy) NSString *endDate;      //结束日期
@property (nonatomic,strong) NSArray *leaveWords;  //留言
@property (nonatomic,copy) NSString *minimumValue; //最少达成金额
@property (nonatomic,copy) NSString *name;         //梦想名称
@property (nonatomic,strong) NSArray *picVid;      //视频，图片
@property (nonatomic,copy) NSString *slogan;       //口号
@property (nonatomic,copy) NSString *state;        //状态1:进行中2:成功3:失败4:驳回
@property (nonatomic,copy) NSString *updateTime;   //修改时间
@property (nonatomic,copy) NSString *updateUser;   //修改人
@property (nonatomic,copy) NSString *userID;       //用户ID
@property (nonatomic,strong) NSArray *dreamReward; //梦想奖励
@property (nonatomic,copy) NSString *cover;        //封面
@property (nonatomic,copy) NSString *homepage;
@property (nonatomic,copy) NSString *isCollect;    //是否被收藏
@property (nonatomic,copy) NSString *raisePercent; //完成百分比
@property (nonatomic,copy) NSString *raiseAmount;  //梦想筹集的总金额
@property (nonatomic,copy) NSString *dreamUser;    //用户头像
@property (nonatomic,strong) NSArray *top3Reward;  //打赏排名前三




@end
