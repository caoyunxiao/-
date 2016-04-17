//
//  SearchViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/13.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
    


@property (weak, nonatomic) IBOutlet UITextField *searchText;//输入框

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//搜索
- (IBAction)cancelBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *SVTableView;




@end
