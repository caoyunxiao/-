//
//  AdWebViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/7.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface AdWebViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (nonatomic, copy) NSString *URL;
@end
