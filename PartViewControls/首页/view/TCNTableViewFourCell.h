//
//  TCNTableViewFourCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/11/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TCNTableViewFourCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *MessageTableView;
@property (weak, nonatomic) IBOutlet UIButton *MessageButton;
@property (nonatomic,copy) NSString *DreamID;         //梦想ID
@property (nonatomic,strong) NSMutableArray *datas;   //数据源
@end
