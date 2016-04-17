//
//  TCHomeViewController.h
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface TCHomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    
   
    
   
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *TCTableView;//首页tableview
@property (weak, nonatomic) IBOutlet UIButton *TCSearch;//搜索按钮
- (IBAction)TCSearch:(UIButton *)sender;



@property (weak, nonatomic) IBOutlet UIButton *signBtn;

- (IBAction)signBtnClick:(UIButton *)sender;

@end












