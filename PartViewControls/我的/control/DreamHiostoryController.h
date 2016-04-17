//
//  DreamHiostoryController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface DreamHiostoryController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tbView;

/*改变RGBRGBRGBRG分vefveveverv额头以后要后天以后不让他好吧BRGBRGB*/
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) BOOL isCao;
@end
