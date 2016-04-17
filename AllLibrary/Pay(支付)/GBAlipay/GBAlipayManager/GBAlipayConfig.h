//
//  GBAlipayConfig.h
//  支付宝极简支付
//
//  Created by marks on 15/6/3.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#ifndef ________GBAlipayConfig_h
#define ________GBAlipayConfig_h

#import <AlipaySDK/AlipaySDK.h>     // 导入AlipaySDK
#import "Order.h"                   // 导入订单类
#import "DataSigner.h"              // 生成signer的类
/**
 *  合作身份者id，以2088开头的16位纯数字
 */
#define PartnerID @"2088021715348160"
/**
 *  收款支付宝账号
 */
#define SellerID  @"cosspay@126.com"

/**
 *  安全校验码（MD5）密钥，以数字和字母组成的32位字符
 */
#define MD5_KEY @"k7u8xcl7qi0l8168xi8n6frnje3go0ab"
/**
 *  appSckeme:应用注册scheme,在Info.plist定义URLtypes，处理支付宝回调
 */
#define kAppScheme @"kanfaniOS"
/**
 *  支付宝服务器主动通知商户交易是否成功 网站里指定的页面 http 路径。非必需
 */
#define kNotifyURL @"www.cosfund.com"
/**
 *  商户私钥，自助生成
 */
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKipLRhkGiDW9WaWq8k+ojkcjPgMH8eNIeKckR0YgqgOiSXNp62wab/da/DM8L9ZmRGYhIJ7yL+anSIX/Y0bpy3amm4Y8vZ+Yn+OZcTzxVQjBlKkYdklWAa+L4I5Siz9OwI19G1nDfeOkIUyyXv5uRNdWbnGDM4sxxVsPP+uJqyRAgMBAAECgYAiB5hQronTDGwRGd9pSFjk2wzaU1/qHGC031AsJbDfBafIV9k4IzsC+kL4H/GHOiW3NiWuShl0B1ci9OI0oVq2guYNyM0ldEEXLGqCxgbKYfVHYXPzV4dT2EMkxvb2GmMZjPjWIudBgfAkfG194b7a7Dm+GsMCQmJ+N8GcXTLoAQJBAM/dPvpk7xZgoP87Wy/eESLwlvUxuqyrGwm/T6c99cuCiDyHi5kOuhEsmFSHWNhGeQDTb8+euSjAMwnXMle93xECQQDPt9jGkGLMTU7MxqV2My89CZGA7hXYyTLhglFjzR6PsO1cGMd61lzjZ/Gokqtw9xJpmWQbxg3xDwX2rkjNHvWBAkATDW1zWAMOIwc+vbsK9SjO8gx0Jv28S+ariwyLAMPhxnIkUiw6eD4XyuWfgdRj5nm62KZ7+klwccV71my33CBxAkA4dgqwfpK8Yc8njl9vb55Jgw5P82dw08/GyHuDG0BRYpBCVmHym84H6jsfzS5YuHAC0DUL75veiGzgjqMvTlkBAkEAmXhZ7TPc0YlE8qwxf/8VkTjQQlCK4U2CUDsSWw7EdfdcCS1hg9wg9dFai7bjSO66RXaXVm4yvwTpdhPFdWFj1w=="
/**
 *  支付宝公钥
 */
#define AlipayPubKey  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"


#endif

