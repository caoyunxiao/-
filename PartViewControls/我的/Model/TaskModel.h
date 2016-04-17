//
//  TaskModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject
/*
 createTime = "/Date(1448107645628+0800)/";
 hasDone = 0;
 name = "\U53d1\U9001\U9080\U8bf7\U7801\U9080\U8bf7\U670b\U53cb";
 note = "<null>";
 reward = 200;
 state = 0;
 taskID = 9;
 type = 4;
 typeName = "\U63a8\U5e7f\U4efb\U52a1";
 */
/**
*  任务创建时间
*/
@property (nonatomic, copy) NSString *createTime;
/**
 *  任务是否完成
 */
@property (nonatomic, strong) NSString *hasDone;
/**
 *  任务名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  任务笔记
 */
@property (nonatomic, copy) NSString *note;
/**
 *  任务奖励
 */
@property (nonatomic, copy) NSString *reward;
/**
 *  任务状态
 */
@property (nonatomic, copy) NSString *state;
/**
 *  任务ID
 */
@property (nonatomic, copy) NSString *taskID;
/**
 *  任务类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  任务名字
 */
@property (nonatomic, copy) NSString *typeName;

@end
