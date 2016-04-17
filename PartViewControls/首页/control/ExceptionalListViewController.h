//
//  ExceptionalListViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeModel.h"

@interface ExceptionalListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *ExceptionalListTable;

@property (nonatomic,retain) HomeModel *homeModel;

@end
