//
//  OnlineViewController.h
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopCell.h"

@interface OnlineViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ShopCellDelgate>{
    NSArray *_dataArrayTop;      //数据源数组
    NSArray *_TitleArrayTop;
    
    NSArray *_dataArrDown;
    NSArray *_TitleArrDown;
    
    BOOL _searchisShow;              //搜索框是否显示
}

@property (weak, nonatomic) IBOutlet UITableView *ShopTableView;//明星周边tableview
@property (weak, nonatomic) IBOutlet UIView *SearchView;//搜索底层view

@property (weak, nonatomic) IBOutlet UITextField *SearchTextField;//搜索输入框
@property (weak, nonatomic) IBOutlet UIButton *SearchButton;//搜索按钮
- (IBAction)SearchButton:(UIButton *)sender;




@end
