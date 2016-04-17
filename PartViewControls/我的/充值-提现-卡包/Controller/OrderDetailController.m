//
//  OrderDetailController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "OrderDetailController.h"
#import "SettleCell.h"       //商品cell


@interface OrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    /*各让他让更不能让给他不能让他给别人听他给别人听别人听别人听不听哥哥哥*/
}

#pragma mark - 配置文件
- (void)configUI
{
    self.title = @"订单详情";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    
    self.tbView.tableFooterView = [[UIView alloc] init];
}
#pragma mark - TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SettleCellId = @"SettleCellId";
    
    SettleCell *settcell = [tableView dequeueReusableCellWithIdentifier:SettleCellId];
    
    if (settcell == nil) {
        settcell = [[[NSBundle mainBundle] loadNibNamed:@"SettleCell" owner:nil options:nil]lastObject];
        
    }
   // OnlineModel *modle = _orderArr[indexPath.row];
    
    OnlineModel *modle = [_orderArr objectAtQYQIndex:indexPath.row];
    
    [settcell configModel:modle];
    return settcell;
}


/*国防部verbver改天不让他跟别人特别听广播bvervberbv*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
