//
//  ZuiXinViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@protocol ZuiXinViewControllerDelegate <NSObject>

- (void)ZuiXinViewControllerDidSelectRowAtIndexPath:(NSIndexPath *)indexPath array:(NSArray *)array;


@end
@interface ZuiXinViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tbView;


@property (nonatomic, copy) NSString *sorting;

@property (nonatomic, assign) id<ZuiXinViewControllerDelegate> delegate;
@end
