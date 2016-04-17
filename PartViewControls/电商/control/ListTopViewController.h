//
//  ListTopViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*列表页面方法**/

#import "BaseViewController.h"

@interface ListTopViewController : BaseViewController{
   
}
@property (weak, nonatomic) IBOutlet UITableView *ListTopTableView;

@property (nonatomic,copy) NSString *wAction;
/**
 *  商品类型ID
 */
@property (nonatomic, copy) NSString *typeID;


@end
