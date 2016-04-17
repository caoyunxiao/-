//
//  InviteFriendModle.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/17.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteFriendModle : NSObject
/*age = 0;
cardNo = "";
describe = "<null>";
email = "<null>";
gender = 0;
headImg = "<null>";
isStar = 0;
nickname = "<null>";
nums = 0;
 realName = "";
userId = 3285;
userName = 15721151236;
*/

@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *cardNo;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *headImg;

@property (nonatomic, copy) NSString *regTime;
@property (nonatomic, copy) NSString *isStar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;


@end
