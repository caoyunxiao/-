//
//  GBWXPayManagerConfig.h
//  微信支付
//
//  Created by 张国兵 on 15/7/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#ifndef _____GBWXPayManagerConfig_h
#define _____GBWXPayManagerConfig_h
//===================== 微信账号帐户资料=======================

#import "payRequsestHandler.h"         //导入微信支付类
#import "WXApi.h"

#define APP_ID          @"wxed5d844c26f5659e"               //APPID
#define APP_SECRET      @"7a604726543be44b02d62963f10173d8" //appsecret
//商户号，填写商户对应参数
#define MCH_ID          @"1276644101"
//商户API密钥，填写相应参数
//#define PARTNER_ID      @"3B689B0104B9D065FAEDDFE320444179"
#define PARTNER_ID      @"s3dkj235JASp240dH2d1Uf25sl13RLww"
//支付结果回调页面
#define NOTIFY_URL      @"www.baidu.com"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"www.baidu.com"

#endif
