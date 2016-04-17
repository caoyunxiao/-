//
//  ReturnCode.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/14.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ReturnCode.h"

@implementation ReturnCode

//返回编码结果
+ (NSString *)getResultFromReturnCode:(NSString *)ReturnCode
{
    NSString *str;
    NSInteger ReturnCodeInter = [ReturnCode integerValue];
    //系统相关
    if(ReturnCodeInter==0)
    {
        str = @"执行成功";
    }
    else if (ReturnCodeInter==-1)
    {
        str = @"初始化";
    }
    else if (ReturnCodeInter==101)
    {
        str = @"参数格式错误";
    }
    else if (ReturnCodeInter==102)
    {
        str = @"必须以POST方式提交";
    }
    else if (ReturnCodeInter==103)
    {
        str = @"请求的方法不存在";
    }
    else if (ReturnCodeInter==104)
    {
        str = @"数据更新失败";
    }
    else if (ReturnCodeInter==105)
    {
        str = @"指定的应用授权不存在";
    }
    else if (ReturnCodeInter==106)
    {
        str = @"接口认证未通过";
    }
    else if (ReturnCodeInter==107)
    {
        str = @"数据查询失败";
    }
    else if (ReturnCodeInter==108)
    {
        str = @"参数值非法";
    }
    else if (ReturnCodeInter==109)
    {
        str = @"写入数据库失败";
    }
    else if (ReturnCodeInter==110)
    {
        str = @"数据集NULL";
    }
    
    else if (ReturnCodeInter==194)
    {
        str = @"系统异常";
    }
    else if (ReturnCodeInter==198)
    {
        str = @"系统繁忙";
    }
    //短信相关
    else if (ReturnCodeInter==1100)
    {
        str = @"验证码发送失败";
    }
    else if (ReturnCodeInter==1101)
    {
        str = @"手机号为空";
    }
    else if (ReturnCodeInter==1102)
    {
        str = @"手机号非法";
    }
    //账户相关
    else if (ReturnCodeInter==1200)
    {
        str = @"用户已经存在";
    }
    else if (ReturnCodeInter==1201)
    {
        str = @"短信验证码错误";
    }
    else if (ReturnCodeInter==1202)
    {
        str = @"登录密码有误";
    }
    else if (ReturnCodeInter==1203)
    {
        str = @"账户不存在";
    }
    else if (ReturnCodeInter==1204)
    {
        str = @"手机号已经存在";
    }
    else if (ReturnCodeInter==1205)
    {
        str = @"邮箱已经存在";
    }
    else if (ReturnCodeInter==1206)
    {
        str = @"咖呗不得小于等于0";
    }
    //支付接口
    else if (ReturnCodeInter==3000)
    {
        str = @"金额非法";
    }
    else if (ReturnCodeInter==3001)
    {
        str = @"充值状态修改异常";
    }
    else if (ReturnCodeInter==3002)
    {
        str = @"订单不存在";
    }
    else if (ReturnCodeInter==3003)
    {
        str = @"余额小于0";
    }
    else if (ReturnCodeInter==3004)
    {
        str = @"充值咖呗失败";
    }

    else if (ReturnCodeInter==3005)
    {
        str = @"充值订单写入失败";
    }
    else if (ReturnCodeInter==3006)
    {
        str = @"充值订单写入成功";
    }
    else if (ReturnCodeInter==3007)
    {
        str = @"奖励咖呗充值失败";
    }
    else if (ReturnCodeInter==3008)
    {
        str = @"奖励咖呗充值失败";
    }
    else if (ReturnCodeInter==3009)
    {
        str = @"奖励咖呗充值失败";
    }
 

    else if (ReturnCodeInter==3010)
    {
        str = @"订单异常，请联系客服";
    }
    else if (ReturnCodeInter==3011)
    {
        str = @"订单已经关闭，请重新下单";
    }
    else if (ReturnCodeInter==3012)
    {
        str = @"订单已经完成";
    }
    else if (ReturnCodeInter==3013)
    {
        str = @"订单状态非法，请联系客服";
    }
    else if (ReturnCodeInter==3014)
    {
        str = @"支付失败，请重新支付";
    }
    else if (ReturnCodeInter==3015)
    {
        str = @"支付成功";
    }
    else if (ReturnCodeInter==3016)
    {
        str = @"金额冻结成功";
    }
    else if (ReturnCodeInter==3017)
    {
        str = @"金额冻结失败";
    }
    else if (ReturnCodeInter==3018)
    {
        str = @"操作RMB不能小于1分钱";
    }
    else if (ReturnCodeInter==3019)
    {
        str = @"操作咖呗不能小于1咖呗";
    }
    else if (ReturnCodeInter==3020)
    {
        str = @"账户现金余额不足";
    }
    else if (ReturnCodeInter==3021)
    {
        str = @"账户咖呗余额不足";
    }
    else if (ReturnCodeInter==3100)
    {
        str = @"充值成功";
    }
    //商品相关
    else if (ReturnCodeInter==1500)
    {
        str = @"商品数量必须大于0";
    }
    //任务相关
    else if (ReturnCodeInter==4000)
    {
        str = @"任务不存在";
    }
    else if (ReturnCodeInter==4001)
    {
       str = @"奖励已经领取";
    }
    else if (ReturnCodeInter==4002)
    {
        str = @"奖励领取异常，联系客服";
    }
    else if (ReturnCodeInter==4003)
    {
        str = @"任务状态异常，联系客服";
    }
    else if (ReturnCodeInter==4004)
    {
        str = @"任务逻辑未完成，联系客服";
    }
    else if (ReturnCodeInter==4005)
    {
        str = @"不满足任务条件，不能领取奖励";
    }
    else if (ReturnCodeInter==4007)
    {
        str = @"任务已经完成，不能重复做任务";
    }
    //梦想相关
    else if (ReturnCodeInter==5001)
    {
        str = @"不能添加多个梦想";
    }

    
    return str;
}









@end
