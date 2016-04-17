//
//  PersonInfo.h
//  微密
//
//  Created by longlz on 14-7-17.
//  Copyright (c) 2014年 longlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfo : NSObject

+ (PersonInfo *)sharePersonInfo;

- (void)resetPersonInfo;

@property (nonatomic,assign) NSInteger selectedIndex; //选择哪一个tabbar

//用户信息
@property (nonatomic,copy) NSString *phone;           //手机号
@property (nonatomic,copy) NSString *passWord;        //密码
@property (nonatomic,copy) NSString *age;             //年纪
@property (nonatomic,copy) NSString *describe;        //自我介绍
@property (nonatomic,copy) NSString *email;           //邮件
@property (nonatomic,copy) NSString *gender;          //性别
@property (nonatomic,copy) NSString *headImg;         //头像
@property (nonatomic,copy) NSString *nickname;        //昵称
@property (nonatomic,copy) NSString *userId;          //用户ID
@property (nonatomic,copy) NSString *userName;        //登录账户
@property (nonatomic,copy) NSString *appversion;      //版本号


//视频的URL
@property (nonatomic,copy) NSURL *videoFileURL;
@property (nonatomic,assign) BOOL isVideo;//是否是视频

@property (nonatomic,assign) BOOL isLogIn;                    //是否已经登录
@property (nonatomic,assign) NSInteger photoCount;            //已选照片数目
@property (nonatomic,assign) BOOL isProcessDreams;            //是否是梦想进程


//上传梦想
@property (nonatomic,strong) NSDictionary *wParamDict;         //参数字典
@property (nonatomic,strong) NSArray *uoLoadImageArray;        //图片数组
@property (nonatomic,strong) NSArray *upLoadResultArr;         //图片ObjectKey数组
@property (nonatomic,strong) UIImage *homePagePic;             //首页
@property (nonatomic,strong) NSString *homePagePicObjectKey;   //首页ObjectKey
@property (nonatomic,strong) NSString *medialistObjectKey;         //视频的KEY



//我的资金信息
@property (nonatomic,copy) NSString *myKaBei;
/**
 *  我的头像二进制
 */
@property (nonatomic, strong) NSData *myHeadImageData;

@end
