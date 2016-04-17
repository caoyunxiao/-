//
//  WelfareModel.h
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 eventID = 1001;
 eventIconUrl = "http://img.adbox.sina.com.cn/pic/3932012482-1443162410430.jpg";
 eventName = "\U5496\U8303\U7c89\U4e1d\U5609\U5e74\U534e\U7b2c\U4e00\U671f";
 eventUrl
 */
@interface WelfareModel : NSObject

/**
 *  eventID
 */
@property (nonatomic, copy) NSString *eventID;
/**
 *  活动图片的URL
 */
@property (nonatomic,copy) NSString *eventIconUrl;
/**
 *  活动名字
 */
@property (nonatomic,copy) NSString *eventName;
/**
 *  活动地址
 */
@property (nonatomic,copy) NSString *eventUrl;

@end
