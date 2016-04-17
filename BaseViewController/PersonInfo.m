//
//  PersonInfo.m
//  微密
//
//  Created by longlz on 14-7-17.
//  Copyright (c) 2014年 longlz. All rights reserved.
//

#import "PersonInfo.h"


static PersonInfo *g_personInfo;

@implementation PersonInfo

+ (PersonInfo *)sharePersonInfo
{
    if (g_personInfo == nil)
    {
        g_personInfo = [[self alloc]init];
    }
    return g_personInfo;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //
    }
    return self;
}

#pragma mark - 释放单利
- (void)resetPersonInfo
{
    self.userId = nil;
    self.phone = nil;
    self.passWord = nil;
    self.age = nil;
    self.describe = nil;
    self.email = nil;
    self.gender = nil;
    self.headImg = nil;
    self.nickname = nil;
    self.userId = nil;
    self.userName = nil;
    self.videoFileURL = nil;
    self.photoCount = 0;
    self.wParamDict = nil;
    self.uoLoadImageArray = nil;
    self.upLoadResultArr = nil;
    self.homePagePic = nil;
    self.homePagePicObjectKey = nil;
    self.medialistObjectKey = nil;
    self.myKaBei = nil;
    self.myHeadImageData = nil;
    self.appversion = nil;
    
    self.isLogIn = NO;
    self.isVideo = NO;
    self.isProcessDreams = NO;
    
    self.selectedIndex = 0;
    
    
    /*
     @property (nonatomic,strong) NSDictionary *wParamDict;         //参数字典
     @property (nonatomic,strong) NSArray *uoLoadImageArray;        //图片数组
     @property (nonatomic,strong) NSArray *upLoadResultArr;         //图片ObjectKey数组
     @property (nonatomic,strong) UIImage *homePagePic;             //首页
     @property (nonatomic,strong) NSString *homePagePicObjectKey;   //首页ObjectKey
     @property (nonatomic,strong) NSString *medialistObjectKey;
     */
  
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passWord"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KLogInType];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KaccessToken];
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:KLogInType];
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:KiconURL];
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:KplatformName];
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:KprofileURL];
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:KuserName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Kusid];
   
  

}

@end
