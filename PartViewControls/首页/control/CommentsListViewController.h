//
//  CommentsListViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/24.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "leaveWordsModel.h"

@interface CommentsListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArray;
    UIView *_answerBackView;                //显示视图
    UITextField *_answerTextField;          //输入框
    leaveWordsModel *_leaveModel;
}

@property (weak, nonatomic) IBOutlet UITableView *CommentsListTable;

@property (nonatomic,copy) NSString *dreamid;

@end
