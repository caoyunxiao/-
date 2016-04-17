//
//  TCNTableViewFourCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/11/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TCNTableViewFourCell.h"
#import "MessageTableViewCell.h"

@implementation TCNTableViewFourCell
{
    
    int Newpage;
}
- (void)awakeFromNib {
    
    [self uiConfigAction];
   
}


#pragma mark -获取梦想ID
- (void)setDreamID:(NSString *)DreamID
{
    _DreamID = DreamID;
    [self getMessageArrayL:1];
}

- (void)uiConfigAction
{
    Newpage = 1;
    self.datas = [NSMutableArray array];
    self.MessageTableView.dataSource = self;
    self.MessageTableView.delegate = self;
    self.MessageButton.layer.cornerRadius = 3;
    self.MessageButton.layer.masksToBounds = YES;
    [self.MessageTableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageTableViewCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SendMessageSuccess:) name:@"SendMessageSuccess" object:nil];
    
    self.MessageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.datas removeAllObjects];
        [self getMessageArrayL:1];
        
    }];
    self.MessageTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        Newpage ++;
        [self getMessageArrayL:Newpage];
        
    }];
}

#pragma mark -获取留言数组
- (void)getMessageArrayL:(int)page
{
    
//    NSDictionary *wParamDict = @{@"dreamid":_DreamID,@"page":@(page),@"size":@(10)};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_DreamID,@"dreamid",@(page),@"page",@(10),@"size", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"505" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if ([errorCode isEqualToString:@"0"]) {
            
            for (UIView *view in self.subviews) {
                
                if ([view isKindOfClass:[UILabel class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            [self endRefreshingNew];
            if([errorCode isEqualToString:@"0"])
            {
                NSArray *resultArr = (NSArray *)resultDict;
                for (NSDictionary *dict in resultArr)
                {
                    leaveWordsModel *model = [[leaveWordsModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    
//                    if (page == 1) {
//                        
//                        [datas removeAllObjects];
//                    }
                    
                    [self.datas addObject:model];
                }
                
                [self.MessageTableView reloadData];
            }
            else
            {
                //获取数据失败
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            }
        }
        else
        {
            
            if (self.datas.count == 0) {
                
                UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
                labe.text = @"暂无留言，快去抢第一个沙发吧!";
                labe.textAlignment = NSTextAlignmentCenter;
                labe.adjustsFontSizeToFitWidth = YES;
                labe.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                [self addSubview:labe];
            }
            
            [self endRefreshingNew];
//            Alert([ReturnCode getResultFromReturnCode:errorCode]);
        }
        
    }];
}


#pragma mark -结束刷新
- (void)endRefreshingNew
{
    if (self.MessageTableView.mj_header.isRefreshing) {
        
        [self.MessageTableView.mj_header endRefreshing];
    }
    if (self.MessageTableView.mj_footer.isRefreshing) {
        
        [self.MessageTableView.mj_footer endRefreshing];
    }
}


#pragma mark -插入留言
- (void)SendMessageSuccess:(NSNotification *)Not
{
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    leaveWordsModel *Model = Not.object;
    [self.datas insertObject:Model atIndex:0];
    [self.MessageTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.MessageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewScrollPositionNone;
    cell.MessagebackView.backgroundColor = [UIColor whiteColor];
    if (self.datas.count != 0) {
        
     // cell.model = self.datas[indexPath.row];
        
        cell.model = [self.datas objectAtQYQIndex:indexPath.row];
        
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datas.count != 0) {
        
        //leaveWordsModel *Model = self.datas[indexPath.row];
        
        leaveWordsModel *Model = [self.datas objectAtQYQIndex:indexPath.row];
        
        return 65+Model.Contentsize.height;
    }
    return 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
