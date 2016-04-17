//
//  InviteFriendViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "InviteFriendCell.h"                      //邀请好友的Cell
#import "InviteFriendModle.h"

@interface InviteFriendViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *inviteArr;             //邀请好友的数据源


/*fbvdfbhrhrthrthdfbdfbnfgrnb*/
@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configUI];
    [self requestDataBase:_page size:_size];
    //[self refreshDghnbrfgtbrtgbhrthbrtbhata:self.tbView];
}

#pragma mark - 配置文件
- (void)configUI
{
    self.title = @"邀请好友列表";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    _inviteArr = [NSMutableArray array];
    self.tbView.tableFooterView = [[UIView alloc]init];
    _myInvientNumber.text = [PersonInfo sharePersonInfo].userId;
    _page = 1;
    _size = 15;
    
    [self.inviteBtn setMyCorner];
    
    //下拉刷新
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self.inviteArr removeAllObjects];
        [self requestDataBase:_page size:_size];

        
    }];
    //上拉加载
    self.tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    
        _page ++;
        [self requestDataBase:_page size:_size];
    }];

}
#pragma mark - 请求服务器数据
- (void)requestDataBase:(NSInteger)page size:(NSInteger)size
{

    __weak typeof(self) wself = self;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];

//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"page":pageStr,@"size":sizeStr};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid",pageStr,@"page",sizeStr,@"size", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"117" completed:^(NSString *errorCode, NSDictionary *resultDict) {

        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }
        if (wself.tbView.mj_footer.isRefreshing) {
            
            [wself.tbView.mj_footer endRefreshing];
        }

        [wself removeLoadingViewZFJ];//移除加载
        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];
           // NSLog(@"邀请的好友列表%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
          
            for (NSDictionary *dict in array) {
                InviteFriendModle *model = [[InviteFriendModle alloc] init];
                model.userName = dict[@"userName"];
                model.regTime = dict[@"regTime"];
                
                [_inviteArr addObject:model];
            }
             
            [wself.tbView reloadData];
        }
        else if ([errorCode isEqualToString:@"110"])
        {
           
            if (_page==1) {
                [wself showLoadingFailureViewZFJ:@"您还没有邀请好友哦"];
            }
            else
            {
                
            }
        }
        else
        {
            NSLog(@"我正在进行的梦想ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            [wself showLoadingFailureViewZFJ:@"数据加载失败，请刷新一下"];    //加载失败
            
            return ;
            
        }
    }];

}

#pragma mark - UITableView的协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _inviteArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
       static NSString *cellId = @"InviteFriendcellId";
       
        InviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"InviteFriendCell" owner:nil options:nil]lastObject];
            
        }
        //InviteFriendModle *model = _inviteArr[indexPath.row];
    
      InviteFriendModle *model = [_inviteArr objectAtQYQIndex:indexPath.row];
    
       [cell configModle:model];
        return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 立即邀请
- (IBAction)OnceInviteBtnClick:(UIButton *)sender {
    
    NSString *returnURL = [NSString stringWithFormat:@"http://event.cosfund.com/xyAppShare/invest2.html?uid=%@",[PersonInfo sharePersonInfo].userId];
    NSString *title = @"咖范@宣言";
    NSString *shareText = @"赶快邀请你的好友赢取咖贝吧";
    
    [self shareWithTitle:title describe:shareText image:[UIImage imageNamed:@"logo"] imageURL:nil video:nil returnURL:returnURL];
    
}
@end









