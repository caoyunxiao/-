//
//  leaveWordsModel.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/27.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface leaveWordsModel : NSObject

/// 梦想留言版

@property (nonatomic,copy) NSString *wordID;   //留言ID
@property (nonatomic,copy) NSString *dreamID;   //梦想ID
@property (nonatomic,copy) NSString *userID;   //用户ID
@property (nonatomic,copy) NSString *nickName;   //昵称
@property (nonatomic,copy) NSString *content;   //留言内容
@property (nonatomic,copy) NSString *createTime;   //创建时间
@property (nonatomic,copy) NSString *state;   //状态
@property (nonatomic,copy) NSString *parentID;   //
@property (nonatomic,strong) NSArray *replyWord;//留言数组
@property (nonatomic,assign) CGSize Contentsize; //留言所占空间
@end
