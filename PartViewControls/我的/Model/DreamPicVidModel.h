//
//  DreamPicVidModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/27.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DreamPicVidModel : NSObject
/*
 Batch = 0;
 CreateTime = "/Date(1448595201937+0800)/";
 Describe = qqq;
 DreamID = 134;
 MediaID = 803;
 State = 0;
 Type = 1;
 Url = "156183538201448595158.png";
 */
/**
*  批次
*/
@property (nonatomic, copy) NSString *Batch;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *CreateTime;
/**
 *  描素
 */
@property (nonatomic, copy) NSString *Describe;
/**
 *  梦想ID
 */
@property (nonatomic, copy) NSString *DreamID;
/**
 *  meitiID
 */
@property (nonatomic, copy) NSString *MediaID;

/**
 *  State
 */
@property (nonatomic, copy) NSString *State;
/**
 *  类型
 */
@property (nonatomic, copy) NSString *Type;
/**
 *  地址
 */
@property (nonatomic, copy) NSString *Url;

@end
