//
//  RequestEngine.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/14.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "RequestEngine.h"
#import "AFHTTPRequestOperationManager.h"

@implementation RequestEngine


//用户模块
+ (void)UserModulescollegeWithDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction completed:(void(^)(NSString *errorCode,NSDictionary *resultDict))completed
{
    //判断网络
    if (SHARED_APPDELEGATE.netWorkStatus == 0) {
        
        if (completed)
        {
            completed(@"-1",nil);
        }
        return;
    }
    
    NSString *wMsgID = [BaseViewController getTheTimestamp];
    NSString *wParam = [BaseViewController getwParamFromDict:wParamDict];
    NSString *wSignStr = [NSString stringWithFormat:@"%@%@%@%@%@",wAgent,wAction,wMsgID,wParam,KLicenseKeys];
    NSString *wSign = [wSignStr stringFromMD5];
    //登录操作
//    NSDictionary * dict = @{@"wAgent":wAgent,@"wAction":wAction,@"wMsgID":wMsgID,@"wSign":wSign,@"wParam":wParam};
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:wAgent,@"wAgent", wAction,@"wAction", wMsgID,@"wMsgID", wSign,@"wSign" ,wParam,@"wParam" , nil];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager POST:LOGINURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * Data = [responseObject objectForKey:@"Data"];
            NSString * ReturnCode = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"ReturnCode"]];
            //NSString * ReturnMsgID = [responseObject objectForKey:@"ReturnMsgID"];
            NSString * UserID = [responseObject objectForKey:@"UserID"];
            if(UserID.length!=0)
            {
                [PersonInfo sharePersonInfo].userId = UserID;
            }
            if (completed)
            {
                completed(ReturnCode,Data);
            }
        }
        else
        {
            if (completed)
            {
                completed(@"-1",nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completed)
        {
            completed(@"-1",nil);
        }
    }];
}
+ (void)QyqModulescollegeWithDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction completed:(void(^)(NSString *errorCode,NSDictionary *resultDict))completed
{
   
    NSString *wMsgID = [BaseViewController getTheTimestamp];
    NSString *wParam = [BaseViewController getwParamFromDict:wParamDict];
    NSString *wSignStr = [NSString stringWithFormat:@"%@%@%@%@%@",wAgent,wAction,wMsgID,wParam,KLicenseKeys];
    NSString *wSign = [wSignStr stringFromMD5];
    //登录操作
//    NSDictionary * dict = @{@"wAgent":wAgent,@"wAction":wAction,@"wMsgID":wMsgID,@"wSign":wSign,@"wParam":wParam};
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:wAgent,@"wAgent", wAction,@"wAction", wMsgID,@"wMsgID", wSign,@"wSign", wParam,@"wParam", nil];
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager POST:LOGINURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * Data = [responseObject objectForKey:@"Data"];
            NSString * ReturnCode = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"ReturnCode"]];
            //NSString * ReturnMsgID = [responseObject objectForKey:@"ReturnMsgID"];
            NSString * UserID = [responseObject objectForKey:@"UserID"];
            if(UserID.length!=0)
            {
                [PersonInfo sharePersonInfo].userId = UserID;
            }
            if (completed)
            {
                completed(ReturnCode,Data);
            }
        }
        else
        {
            if (completed)
            {
                completed(@"-1",nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completed)
        {
            completed(@"-1",nil);
        }
    }];
}

//
+ (NSDictionary *)requestDataWithWParamDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction
{
    NSString *wMsgID = [BaseViewController getTheTimestamp];
    NSString *wParam = [BaseViewController getwParamFromDict:wParamDict];
    NSString *wSignStr = [NSString stringWithFormat:@"%@%@%@%@%@",wAgent,wAction,wMsgID,wParam,KLicenseKeys];
    NSString *wSign = [wSignStr stringFromMD5];
    //登录操作
    NSDictionary * dict = @{@"wAgent":wAgent,@"wAction":wAction,@"wMsgID":wMsgID,@"wSign":wSign,@"wParam":wParam};
    NSString *bodyString  = [BaseViewController getBodyStringFromDict:dict];
    NSData *data = [HTTPPostManger requestSynchronization:LOGINURL bodyString:bodyString];
    if ([data length] == 0)
    {
        //请求失败  再试
        return nil;
    }
    
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (responseObject == nil)
    {
        //请求失败  再试
        return nil;
    }
    else
    {
        //[PersonInfo sharePersonInfo].userId = UserID;
        
        return responseObject[@"Data"];
    }
}

+ (id)getrequestDataWithWParamDict:(NSDictionary *)wParamDict wAction:(NSString *)wAction
{
    NSString *wMsgID = [BaseViewController getTheTimestamp];
    NSString *wParam = [BaseViewController getwParamFromDict:wParamDict];
    NSString *wSignStr = [NSString stringWithFormat:@"%@%@%@%@%@",wAgent,wAction,wMsgID,wParam,KLicenseKeys];
    NSString *wSign = [wSignStr stringFromMD5];
    //登录操作
//    NSDictionary * dict = @{@"wAgent":wAgent,@"wAction":wAction,@"wMsgID":wMsgID,@"wSign":wSign,@"wParam":wParam};
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:wAgent,@"wAgent", wAction,@"wAction", wMsgID,@"wMsgID", wSign,@"wSign",wParam,@"wParam", nil];
    
    NSString *bodyString  = [BaseViewController getBodyStringFromDict:dict];
    NSData *data = [HTTPPostManger requestSynchronization:LOGINURL bodyString:bodyString];
    if ([data length] == 0)
    {
        //请求失败  再试
        return nil;
    }
    
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (responseObject == nil)
    {
        //请求失败  再试
        return nil;
    }
    else
    {
        //[PersonInfo sharePersonInfo].userId = UserID;
        
        return responseObject;
    }
}



















@end
