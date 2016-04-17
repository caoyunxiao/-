//
//  DetailWebViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/18.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailWebViewController : BaseViewController
/**
 *  链接
 */
@property (nonatomic, copy) NSString *eventURL;

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end
