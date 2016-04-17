//
//  PersonModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject
/*
 age = 23;
 cardNo = "";
 describe = "fhhbbb ";
 email = "zhouxingchw@163.com";
 gender = 2;
 headImg = "131209039701448246992.jpg";
 isStar = 0;
 nickname = "\U4f60\Uff0c\U5728\U4e8e\U6211\U4eec";
 nums = 0;
 realName = "";
 userId = 0;
 userName = "";
 */
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *cardNo;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *isStar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *nums;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;

@end
