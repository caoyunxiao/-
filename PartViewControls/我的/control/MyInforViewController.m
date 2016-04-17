//
//  MyInforViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "MyInforViewController.h"
#import "SettingViewController.h"          //设置页面的视图控制器
#import "PersonalFileViewController.h"     //个人档案视图控制器
#import "DreamHiostoryController.h"        //梦醒秀历史
#import "SettelViewController.h"           //订单结算视图控制器
#import "LGIndexViewController.h"          //登陆视图控制器
#import "RechargeViewController.h"         //充值视图控制器
#import "ConversionKabeiController.h"      //兑换咖贝视图控制器
#import "MycheckViewController.h"          //我的账单视图控制器
#import "InviteFriendViewController.h"     //邀请好友的视图控制器

#import "PersonalHomepageController.h"     //个人主页视图控制器
#import "ProductDetailsViewController.h"   //商品详情页

#import "TCNewDetailViewController.h"      //梦想详情的控制器

#import "PublishedPhotosViewController.h"   //梦想发布
#import "SCNavigationController.h"         //发布梦想拍照



#import "UIBarButtonItem+Create.h"        //分类


#import "MyInfoHeaderView.h"              //tableView头部视图
#import "MyInfoShowViewCell.h"            //我的梦想秀Cell
#import "AddDreamCell.h"                  //立即添加我的梦想
#import "TaskCell.h"                      //任务栏的Cell



#import "ShoppingCell.h"                  //购物车Cell
#import "ShoppingButtomCell.h"            //购物车底部视图
#import "LoadingButton.h"
//数据模型
#import "SupportModel.h"                  //支持的梦想详情
#import "TaskModel.h"                     //任务模型
#import "OnlineModel.h"                   //明星周边模型
#import "HomeModel.h"                     //梦想模型
#import "PicVidListModel.h"               //商品图片数组
@interface MyInforViewController ()<UIActionSheetDelegate,SCNavigationControllerDelegate>
{
    LoadingButton *_loadButton;
    NSInteger _loadingCount;
    BOOL isRefreshingNew;
    BOOL isRefreshingOld;
    
    NSIndexPath *_signIndexpath;
    
    /**
     *  导航栏
     */
    UINavigationController *navigation;
}
@property (nonatomic, strong) UIView *noLoginView;                //未登陆页面弹出页面

//数据源
@property (nonatomic, strong) NSMutableArray *goodsArr;            //存放购物车清单数组
@property (nonatomic, strong) NSMutableArray *selectGoodsArr;      //选中的商品数组

@property (nonatomic, copy) NSString *renminbiBalanceStr;          //人民币余额
@property (nonatomic, copy) NSString *kabeiBalanceStr;              //咖贝余额

@property (nonatomic, strong) NSMutableArray *supportMeArr;        //支持我的人
@property (nonatomic, strong) NSMutableArray *mySupportArr;        //我支持的人

@property (nonatomic, strong) NSMutableArray *taskArr;             //任务数据源
@property (nonatomic, assign) BOOL isDream;
@property (nonatomic, strong) HomeModel *dreamModle;               //我正在进行的梦想
@end

@implementation MyInforViewController

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    //初始化选中的购物车
    
    [self initSelectGoodsArray];                                      //存放选中的商品
    
    [self.tbView reloadData];
    
}
#pragma mark - 视图已经消失的时候
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
  //  [_noLoginView removeFromSuperview];
    
}
#pragma mark - 视图将要加载的时候
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //判断用户是否登录，所有ViewDidload方法都在此函数里面写
    
    if ([PersonInfo sharePersonInfo].isLogIn == YES) {
        [self setupSettingBarButton];
        
        
        [self SEtUpTableView];
        
        //初始化梦想的数据源
        [self initSupportData];
        //获取正在进行的梦想的数据源
        [self getProcessDreamData:YES];
        //初始化购物车数据源
        [self initShoppingCartdata];
        //获取余额
        [self initBalance];
        //获取任务列表
        [self getTAskListData];
    }
    
    //接收登陆成功的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess:) name:@"loginSuccess" object:nil];
    //接收加入购物车通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveShoppingCartadd:) name:@"REFRESH_SHOPPING_CART" object:nil];
    //收到删除购物车的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleShoppingCateTwo:) name:@"deleShoppingCateTwo" object:nil];
    //收到充值成功的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiverechargeCharge:) name:@"rechageSuccess" object:nil];
    //接收到兑换咖贝成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveConversionKabeiSuccess:) name:@"ConversionKabeiSuccess" object:nil];
    //购买成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingSuccess:) name:@"shoppingSuccess" object:nil];
    //打赏成功
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rewordSuccess:) name:@"RefreshMyinfoKabei" object:nil];
    //终止梦想
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(abandonDream:) name:@"abandonDream" object:nil];
    //梦想发布成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publshSuccess:) name:@"PublishDreamSuccess" object:nil];
    //收到签到成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signSuccess) name:@"signSuccess" object:nil];
}



#pragma mark - 收到发布梦想成功的通知
- (void)publshSuccess:(NSNotification *)notification
{
    [self removeLoadingViewZFJ];
    [self SHOWPrompttext:@"发布梦想成功"];
    //上传成功
    
    [self getProcessDreamData:YES];
}
#pragma mark - 收到签到成功的通知
- (void)signSuccess
{
    [self initBalance];
   
    
   
//   UITableViewCell *cell = (UITableViewCell *)[self.tbView cellForRowAtIndexPath:_signIndexpath];
    
//     TaskModel *model =  [[_taskArr objectAtQYQIndex:2] objectAtQYQIndex:0];
//    
//     model.hasDone = @"1";
    
    [self getTAskListData];
    
//    [self.tbView reloadData];
    
    
}

#pragma mark - 收到登陆成功的通知
- (void)loginSuccess:(NSNotification *)notification
{
    /*jntyjntyjnyhntyntynynt*/
    
    //登陆成功之后，重新加载页面和数据源
    [self setupSettingBarButton];
    [self SEtUpTableView];
    //初始化梦想的数据源
    [self initSupportData];
    // [self mysupportRequestData];
    //获取正在进行的梦想
    [self getProcessDreamData:YES];
    //初始化购物车数据源
    [self initShoppingCartdata];
    //获取任务列表
    [self getTAskListData];
    //获取余额
    [self initBalance];
    
}




#pragma mark - 收到购买成功的通知
- (void)shoppingSuccess:(NSNotification *)notification
{
    //刷新余额；
    [self initBalance];
    //刷新购物车；
    [self initShoppingCartdata];
}
#pragma mark - 收到添加到购物车的通知
- (void)receiveShoppingCartadd:(NSNotification *)notification
{
    [self initShoppingCartdata];
    
}
- (void)deleShoppingCateTwo:(NSNotification *)notification
{
    [self initShoppingCartdata];
    
}
#pragma mark - 收到充值成功的通知
- (void)receiverechargeCharge:(NSNotification *)notification
{
    //请求余额的接口
    [self initBalance];
}
#pragma mark - 收到兑换咖贝成功的通知
- (void)receiveConversionKabeiSuccess:(NSNotification *)notification
{
    //请求余额的接口,再次请求余额
    [self initBalance];
}
#pragma mark - 收到打赏成功的通知
- (void)rewordSuccess:(NSNotification *)notification
{
    //重新刷新余额
    [self initBalance];
    //重新刷新梦想数据源
    [self initSupportData];
}
#pragma mark - 终止梦想的通知
- (void)abandonDream:(NSNotification *)notification
{
    //重新刷新数据源
    [self initSupportData];
    [self getProcessDreamData:YES];
}

#pragma mark - 获取用户进行中的梦想
- (void)getProcessDreamData:(BOOL)isRefreshing
{
    __weak typeof(self) wself = self;
    self.dreamModle = [[HomeModel alloc] init];
    //NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    
    //[self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"509" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        //[wself removeLoadingViewZFJ];//移除加载
        [self removeLoadingFailureViewZFJ];
        NSLog(@"获取用户进行中的梦想%@",errorCode);
        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }

        if([errorCode isEqualToString:@"0"])
        {

            [wself removeLoadingFailureViewZFJ];
            NSArray *array = (NSArray *)resultDict;
            NSMutableDictionary *dict = [array firstObject];
            [wself.dreamModle setValuesForKeysWithDictionary:dict];
            [wself.tbView reloadData];
//            [wself.tbView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
            
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            [wself.tbView reloadData];
            
            _isDream = NO;
        }
        else
        {
            NSLog(@"我正在进行的梦想ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            //Alert([ReturnCode getResultFromReturnCode:errorCode])
             [self showLoadingFailureViewZFJ:@"数据加载失败,请稍后再试"];    //加载失败
            
            return ;
            
        }
        
        if (isRefreshing) {
            
            //局部刷新
            [self initSupportData];
            [self initBalance];
        }

    }];
}


#pragma mark - 初始化数梦想数据源
- (void)initSupportData
{
    _supportMeArr = [NSMutableArray array]; //支持我的人
    
    __weak typeof(self) wself = self;
    //[self showLoadingViewZFJ];
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"207" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        //[wself removeLoadingViewZFJ];//移除加载
        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }
        isRefreshingNew = YES;
        if([errorCode isEqualToString:@"0"])
        {
           // NSLog(@"支持我的人%@",resultDict);
            [self removeLoadingFailureViewZFJ];
            NSArray *array = (NSArray *)resultDict;
            
            for (NSDictionary *dict in array) {
                
                SupportModel *model = [[SupportModel alloc] init];
                
                model.amount = [dict[@"amount"] description];
                model.beRewardUid = [dict[@"beRewardUid"] description];
                model.createTime = [dict[@"createTime"] description];
                model.dreamID = [dict[@"dreamID"] description];
                
                model.headImg = [dict[@"headImg"] description];
                
                model.nickName = [dict[@"nickName"] description];
                model.rewardID = [dict[@"rewardID"] description];
                model.rewardUid = [dict[@"rewardID"] description];
                model.state = [dict[@"rewardID"] description];
                model.userID = [dict[@"userID"] description];
               /*uyyghuiph9puhiu9hiouhi9ypiughpiughuihi**/
                [_supportMeArr addObject:model];
                
            }
            [wself.tbView reloadData];
//            [wself.tbView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            
        }
        else
        {
            NSLog(@"支持我的人ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            [self showLoadingFailureViewZFJ:@"数据加载失败,请稍后再试"];    //加载失败
            
            return ;
            
        }
    }];
    
    _mySupportArr = [NSMutableArray array];        //我支持的人
    //接口请求参数
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"206" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        //[wself removeLoadingViewZFJ];//移除加载
        if([errorCode isEqualToString:@"0"])
        {
            NSLog(@"我支持的人%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            
            for (NSDictionary *dict in array) {
                
                SupportModel *model = [[SupportModel alloc] init];
                
                model.amount = [dict[@"amount"] description];
                model.beRewardUid = [dict[@"beRewardUid"] description];
                model.createTime = [dict[@"createTime"] description];
                model.dreamID = [dict[@"dreamID"] description];
                
                model.headImg = [dict[@"headImg"] description];
                
                model.nickName = [dict[@"nickName"] description];
                model.rewardID = [dict[@"rewardID"] description];
                model.rewardUid = [dict[@"rewardID"] description];
                model.state = [dict[@"rewardID"] description];
                model.userID = [dict[@"userID"] description];
            [_mySupportArr addObject:model];

            }
            [wself.tbView reloadData];

        }
        else
        {
           // NSLog(@"我支持的人ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            //[self showLoadingFailureViewZFJ:@"数据加载失败,请稍后再试"];    //加载失败
            return ;
        }
    }];
    
    
}
#pragma mark - 初始化购物车数据源
- (void)initShoppingCartdata
{
    
    _goodsArr = [NSMutableArray array]; //购物车的数据源
    
    //NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"113" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
           // NSLog(@"购物车的数据源%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            if (_buttonFlag==4) {
                if (array.count>0) {
                    self.myShoppingButtomView.hidden = NO;
                    
                }
                else{
                    self.myShoppingButtomView.hidden = YES;
                }
            }
            
            for (NSDictionary *dict in array) {
                
                OnlineModel *model = [[OnlineModel alloc]init];
                model.caBei = [dict[@"caBei"] description];
                model.cover = dict[@"cover"];
                model.color = dict[@"color"];
                model.discription = dict[@"discription"];
                model.goodsID = dict[@"goodsID"];
                model.name = dict[@"name"];
                for (NSDictionary *dict2 in dict[@"picVidList"]) {
                    PicVidListModel *model2 = [[PicVidListModel alloc] init];
                    model2.describe = dict2[@"describe"];
                    model2.type = dict2[@"type"];
                    model2.url = dict2[@"url"];
                    [model.picVidList addObject:model2];
                    
                }
                
                model.price = dict[@"price"];
                model.salesGoodsID = [dict[@"salesGoodsID"] description];
                model.salesID = [dict[@"salesID"] description];
                model.style = dict[@"style"];
                model.total = [dict[@"total"] description];
                model.type = [dict[@"type"] description];
                
                [_goodsArr addObject:model];
            }
            
            [self.tbView reloadData];
            
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
    
    
    
}
#pragma mark - 初始化购物车选中数据
- (void)initSelectGoodsArray
{
    [_selectGoodsArr removeAllObjects];
    _selectGoodsArr = [NSMutableArray array];
    
    _selectBtnClick.selected = NO;
    OnlineModel *model = [[OnlineModel alloc] init];
    for (model in _goodsArr) {
        
        model.selected = NO;
        
        
    }
    
}
#pragma mark - 初始化余额的数据源
- (void)initBalance
{
    __weak typeof(self) wself = self;
    //NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"304" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }
        isRefreshingOld = YES;
        if([errorCode isEqualToString:@"0"])
        {
           // NSLog(@"人民币余额%@",resultDict);
            //邱亚青在此接受人民币余额
            NSArray *array = (NSArray *)resultDict;
            wself.renminbiBalanceStr = [array[0] description];
            
            [wself.tbView reloadData];

            
        }
        if ([errorCode isEqualToString:@"3003"]) {
            wself.renminbiBalanceStr = @"0";
        }
        else
        {
            NSLog(@"人民币余额ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            return ;
        }
    }];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"305" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            //NSLog(@"咖贝余额%@",resultDict);
            
            NSArray *array = (NSArray *)resultDict;
            wself.kabeiBalanceStr = [array[0] description];
            
            [wself.tbView reloadData];

        }
        if ([errorCode isEqualToString:@"3003"]) {
            wself.kabeiBalanceStr = @"0";
        }
        else
        {
            NSLog(@"咖贝余额ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            return ;
        }
    }];
    
}
#pragma mark - 初始化任务列表
- (void)getTAskListData
{
    _taskArr = [NSMutableArray array];
    __weak typeof(self) wself = self;
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"109" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
           // NSLog(@"任务列表%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            
            NSMutableArray *arrayOne = [NSMutableArray array];
            NSMutableArray *arrayTwo = [NSMutableArray array];
            NSMutableArray *arrayThree = [NSMutableArray array];
        
            
            for (NSDictionary *dict in array) {
                TaskModel *model = [[TaskModel alloc] init];
                model.name = dict[@"name"];
                model.type = [dict[@"type"] description];
                model.reward = [dict[@"reward"] description];
                model.hasDone = [dict[@"hasDone"] description];
                model.taskID = [dict[@"taskID"] description];
                model.typeName = dict[@"typeName"];
                if ([model.type.description isEqualToString:@"1"]) {
                    
                    [arrayOne addObject:model];
                }
                if ([model.type.description isEqualToString:@"2"]) {
                    
                    [arrayTwo addObject:model];
                }

                if ([model.type isEqualToString:@"4"]) {
                    [arrayThree addObject:model];
                }
            }
            [wself.taskArr addObject:arrayOne];
            [wself.taskArr addObject:arrayTwo];
            [wself.taskArr addObject:arrayThree];
    
            
            [wself.tbView reloadData];
        }
        else
        {
            NSLog(@"任务列表ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
            return ;
        }
    }];
    
}

#pragma mark - 设置导航栏按钮
- (void)setupSettingBarButton
{
    UIBarButtonItem *setting = [UIBarButtonItem barButtonItemWithImage:@"shezhi" highImage:nil target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItem = setting;
    
    _loadButton = [[[NSBundle mainBundle] loadNibNamed:@"LoadingButton" owner:self options:nil] lastObject];
    _loadButton.frame = CGRectMake(0, 0, 40, 35);
    _loadButton.clipsToBounds = YES;
    UIBarButtonItem *loadBtn = [[UIBarButtonItem alloc]initWithCustomView:_loadButton];
    self.navigationItem.leftBarButtonItem = loadBtn;
    _loadButton.hidden = YES;
    
}
#pragma mark - 点击设置按钮
- (void)settingClick
{
    
    if ([PersonInfo sharePersonInfo].isLogIn != YES) {
        //提示去登陆
        [self showLogInViewController];
        
    }
    else{
        
        SettingViewController *setingVc = [[SettingViewController alloc] init];
        
        setingVc.title = @"设置";
        setingVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setingVc animated:YES];
        
        
        
        
    }
    
}

#pragma mark - 创建UITbaleView

- (void)SEtUpTableView
{

    //创建底部视图
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    [self.tbView setShowsHorizontalScrollIndicator:NO];
    self.tbView.showsVerticalScrollIndicator = YES;
    _buttonFlag = 1;
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49-64) style:UITableViewStyleGrouped];
    if (_buttonFlag == 3||_buttonFlag == 4) {
        _tbView.backgroundColor = kColor(234, 235, 236);
    }
    
    _tbView.backgroundColor = [UIColor whiteColor];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    
    [self creatHeaderView];
    //显示底部视图
    [self.view bringSubviewToFront:self.myShoppingButtomView];
    _myShoppingButtomView.hidden = YES;
    
    if (_buttonFlag == 4) {
        
        _myShoppingButtomView.hidden = NO;
    }
    
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getProcessDreamData:YES];
        
    }];
    [self.tbView.mj_header beginRefreshing];

    /*ybhrwthrwthrthrthrwthrth*/
    
    
}

#pragma mark - 创建头部视图
- (void)creatHeaderView
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyInfoHeaderView" owner:nil options:nil];
    
    //创建头部视图
    MyInfoHeaderView *header = [array firstObject];
    if (_buttonFlag == 1) {
        header.showBtn.selected = YES;
    }
    if (_buttonFlag == 2) {
        header.purseBtn.selected = YES;
    }
    if (_buttonFlag == 3) {
        header.taskBtn.selected = YES;
    }
    if (_buttonFlag == 4) {
        header.shoppingCartBtn.selected = YES;
    }
    self.showBtn = header.showBtn;
    self.purseBtn = header.purseBtn;
    
    self.taskBtn = header.taskBtn ;
    self.shoppingCartBtn = header.shoppingCartBtn;
    
    header.delegate = self;
    
    _tbView.tableHeaderView = header;
    
    [self.view addSubview:_tbView];
}

#pragma mark - UITbaleView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_buttonFlag == 3) {
        return self.taskArr.count+1;
        
    }
    
    return 1;
}
//返回每行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_buttonFlag == 1) {
        return 4;
    }
    if (_buttonFlag == 2) {
        return 1;
    }
    if (_buttonFlag == 3) {
        if (section == 0) {
            return 1;
        }
        return [_taskArr[section-1] count];
        
    }
    //购物车
    return _goodsArr.count;
}
#pragma mark - 返回每个cell的详情
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@" 返回每个cell的详情%d",_isDream);
    
    //点击梦想秀
    if (_buttonFlag == 1) {
        
        if (indexPath.row == 0) {
            //立即添加我的梦想
            if ([self.dreamModle.dreamID description].length>0 || !isRefreshingNew || !isRefreshingOld) {
                static NSString *myDreamcellId = @"cellId";
                UITableViewCell *myDreamcell = [tableView dequeueReusableCellWithIdentifier:myDreamcellId];
                
                if (myDreamcell == nil) {
                    myDreamcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myDreamcellId];
                }
                myDreamcell.imageView.image = [UIImage imageNamed:@"my_left_dream"];
                myDreamcell.textLabel.text = @"我的梦想秀";
                [myDreamcell.textLabel setTextColor:kColor(151, 152, 153)];
                
                myDreamcell.detailTextLabel.text = self.dreamModle.name;
                myDreamcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return myDreamcell;
                /*二个人个人股4551214555141热改革若干*/
            }
            else
            {

                static NSString *addDreamcellId = @"AddDreamCellId";
                AddDreamCell *addDreamcell = [tableView dequeueReusableCellWithIdentifier:addDreamcellId];
                if (addDreamcell == nil) {
                    addDreamcell = [[[NSBundle mainBundle] loadNibNamed:@"AddDreamCell" owner:nil options:nil] lastObject];
                }
                
                return addDreamcell;

            }
            
        }
        if (indexPath.row  ==1) {
            static NSString *myDreamcellId = @"histyoryCellId";
            UITableViewCell *myDreamcell = [tableView dequeueReusableCellWithIdentifier:myDreamcellId];
            
            if (myDreamcell == nil) {
                myDreamcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myDreamcellId];
            }
            myDreamcell.imageView.image = [UIImage imageNamed:@"my_left_dream"];
            myDreamcell.textLabel.text = @"梦想秀历史";
            [myDreamcell.textLabel setTextColor:kColor(151, 152, 153)];
            myDreamcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return myDreamcell;
        }
        static NSString *CellId = @"MyInfoShowViewCell";
        
        MyInfoShowViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyInfoShowViewCell" owner:nil options:nil]lastObject];
            
        }
        NSArray *supportMeArr;
        NSArray *mySupportArr;
        
        NSRange rang = NSMakeRange(0, 20);
        
        if (_supportMeArr.count>20) {
            
            supportMeArr = [_supportMeArr subarrayWithRange:rang];
            
        }
        else
        {
            supportMeArr = _supportMeArr;
        }
        
        if (_mySupportArr.count>20) {
            mySupportArr = [_mySupportArr subarrayWithRange:rang];
        }
        else
        {
            mySupportArr = _mySupportArr;
            
        }
        
        cell.navc = self.navigationController;
        [cell configDataRow:indexPath supportMeArray:supportMeArr mySupportArr:mySupportArr];
        return cell;
        
    }
    //选中钱包
    if (_buttonFlag == 2) {
        
        static NSString *MyPurseCellID = @"MyPurseCellId";
        
        MyPurseCell *cell = [tableView dequeueReusableCellWithIdentifier:MyPurseCellID];
        
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyPurseCell" owner:self options:nil] lastObject];
        }
        
        cell.balanceLabel.text = self.renminbiBalanceStr;
        cell.kabeiLabel.text = self.kabeiBalanceStr;
        cell.delegate = self;
        return cell;
        
    }
    //点击任务
    if (_buttonFlag == 3) {
        
        
        if(indexPath.section==0)
        {
            static NSString *str = @"TaskCellOneId";
            TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if(cell==nil)
            {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TaskCell" owner:self options:nil]objectAtIndex:0];
                
            }
            return cell;
        }
        else if(indexPath.section ==3)
        {
            static NSString *str = @"TaskCellThreeId";
            TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            
            if(cell==nil)
            {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TaskCell" owner:self options:nil]objectAtIndex:2];
                
            }
            //TaskModel *model = _taskArr[indexPath.section-1][indexPath.row];
            
            TaskModel *model = [_taskArr[indexPath.section-1] objectAtQYQIndex:indexPath.row];
            
            [cell configDataWithThreeCell:model];
            return cell;
        }
        else
        {
            static NSString *str = @"TaskCellTwoId";
            TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            
            if(cell==nil)
            {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TaskCell" owner:self options:nil]objectAtIndex:1];
                
            }
            
//            [[_taskArr objectAtQYQIndex:indexPath.section-1] objectAtQYQIndex:indexPath.row];
            
            TaskModel *model =  [[_taskArr objectAtQYQIndex:indexPath.section-1] objectAtQYQIndex:indexPath.row];
            
            ;
            
            [cell configData:model];
            return cell;

        }
        
    }
    //点击购物车
    static NSString *ShoppingCellId = @"ShoppingCellId";
    
    ShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCellId] ;
    
    
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCell" owner:self options:nil] lastObject];
    }
    
    if (_goodsArr.count>0) {
       // OnlineModel *model = _goodsArr[indexPath.row];
        
        OnlineModel *model = [_goodsArr objectAtQYQIndex:indexPath.row];
        
        [cell configModel:model];
    }
    
    [cell.selectBtn addTarget:self action:@selector(cellSelectBtnClict:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
#pragma mark - 点击cell上的按钮的方法
- (void)cellSelectBtnClict:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    ShoppingCell *cell = (ShoppingCell *)[[sender superview] superview];
    
    
    NSIndexPath * indexPath = [self.tbView indexPathForCell:cell];
    
    //OnlineModel *model = _goodsArr[indexPath.row];
    OnlineModel *model = [_goodsArr objectAtQYQIndex:indexPath.row];
    
    if (sender.selected == YES) {
        model.selected = sender.selected;
        [_selectGoodsArr addObject:model];
    }
    if (sender.selected == NO) {
        model.selected  = NO;
        
        [_selectGoodsArr removeObject:model];
    }
    
    
    if (_selectGoodsArr.count == _goodsArr.count) {
        //全选按钮选中
        _selectBtnClick.selected = YES;
        
    }
    else
    {
        _selectBtnClick.selected = NO;
    }
}

#pragma mark - UIActionSheet的协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //监听梦想发布
    if (self.dreamModle.userID.length>0) {
        Alert(@"您已经发布过梦想");
        return;
    }
    switch (buttonIndex) {
        case 0:
            //选择拍照
        {
            
            //判断是否是个人中心调用
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"MyinfoView"];
            SCNavigationController *nav = [[SCNavigationController alloc] init];
            nav.scNaigationDelegate = self;
            [nav showCameraWithParentController:self];
            break;
        }
        case 1:
            //选择传视频
        {
            id<ALBBQuPaiPluginPluginServiceProtocol> sdk = [[TaeSDK sharedInstance] getService:@protocol(ALBBQuPaiPluginPluginServiceProtocol)];
            [sdk setDelegte:(id<QupaiSDKDelegate>)self];
            UIViewController *recordController = [sdk createRecordViewControllerWithMaxDuration:20.0
                                                                                        bitRate:800*1000
                                                                    thumbnailCompressionQuality:1.0
                                                                                 watermarkImage:nil
                                                                              watermarkPosition:QupaiSDKWatermarkPositionTopRight
                                                                                      tintColor:TCColor
                                                                                enableMoreMusic:NO
                                                                                   enableImport:YES
                                                                              enableVideoEffect:YES];
            
            navigation = [[UINavigationController alloc] initWithRootViewController:recordController];
            navigation.navigationBarHidden = YES;
            [self presentViewController:navigation animated:YES completion:nil];

            break;
        }
        default:
            break;
    }
}
#pragma amrk -录制视频回调
- (void)qupaiSDK:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    if (videoPath == nil) {
        
        return;
    }
    NSLog(@"2Qupai SDK compelete %@",videoPath);
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
    }
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
    PublishedPhotosViewController *rvc = [[PublishedPhotosViewController alloc]init];
    rvc.videoFileURL = [NSURL fileURLWithPath:videoPath];
    rvc.VideoString = videoPath;
    rvc.resourceType = @"video";
    [navigation pushViewController:rvc animated:YES];
}

#pragma mark - 视频SCNavigationController代理方法
- (void)didTakePicture:(SCNavigationController *)navigationController imagearr:(NSArray *)imagearr
{
    /*rgrgrgergergerrtgrg4r5ggerger*/
    PublishedPhotosViewController *rvc = [[PublishedPhotosViewController alloc]init];
    rvc.imageArray = imagearr;
    rvc.resourceType = @"photo";
    [navigationController pushViewController:rvc animated:YES];
}

#pragma mark - 点击cell的调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_buttonFlag == 1 ) {
        
        if (indexPath.row == 0) {
            if ([self.dreamModle.dreamID description].length>0) {
                //跳转到梦想详情
                TCNewDetailViewController *detailDreamVc = [[TCNewDetailViewController alloc] init];
                detailDreamVc.dreamID= self.dreamModle.dreamID;
                [self.navigationController pushViewController:detailDreamVc animated:YES];
                
            }
            else
            {
                
                UIActionSheet *actionsheet =[[UIActionSheet alloc] initWithTitle:@"发布梦想" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"拍视频", nil];
                [actionsheet showInView:self.view];
            }
            
        }
        if (indexPath.row == 1) {
            DreamHiostoryController *Vc = [[DreamHiostoryController alloc] init];
            
            Vc.userId = [PersonInfo sharePersonInfo].userId;
            [self.navigationController pushViewController:Vc animated:YES];
        }
        
    }
    if (_buttonFlag == 3) {
        //点击做任务的按钮
        if (indexPath.section == 0) {
            
        }
        else if (indexPath.section == 3 ) {
            InviteFriendViewController *inVc = [[InviteFriendViewController alloc] init];
            
            [self.navigationController pushViewController:inVc animated:YES];
        }
        else
        {
           
            TaskModel *model =  [[_taskArr objectAtQYQIndex:indexPath.section-1] objectAtQYQIndex:indexPath.row];
            
            __weak typeof(self) wself = self;
//            NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"taskid":model.taskID};
        
            NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", model.taskID,@"taskid", nil];
             NSLog(@"成功获取奖励后，重新刷新钱包金额%@",indexPath);
            [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"108" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                
                if([errorCode isEqualToString:@"4001"])
                {
                    //成功获取奖励后，重新刷新钱包金额
                    _signIndexpath = indexPath;
                   
                    
                    [wself initBalance];
                     model.hasDone = @"1";
                    [wself.tbView reloadData];
                    
                    Alert(@"成功完成此任务");
                }
               
                else
                {
                    NSLog(@"做任务ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
                  
                    Alert([ReturnCode getResultFromReturnCode:errorCode]);
                    return ;
              
                }
                
            }];
        }
        
    }
    
    if (_buttonFlag == 4) {
        
        NSLog(@"点击了cell");
        ProductDetailsViewController *prductVc = [[ProductDetailsViewController alloc] init];
        
        if (_goodsArr.count>0) {
            
            OnlineModel *modle = _goodsArr[indexPath.row];
            
            
            prductVc.goodsID = modle.goodsID.description;
            
            prductVc.isShopingCate = YES;
            
            [self.navigationController pushViewController:prductVc animated:YES];
        }
        
       
    }
}
#pragma mark - 返回每一组的头部视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_buttonFlag==3) {
        
        if (section != 0) {
            //TaskModel *modle = [_taskArr[section-1] firstObject];
            
            
            
            TaskModel *modle = [[_taskArr objectAtQYQIndex:section-1] objectAtQYQIndex:0];
            
            return modle.typeName;
        }
        return nil;
        
    }
    return nil;
}

#pragma mark - 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_buttonFlag == 1) {
        
        if (indexPath.row == 0||indexPath.row == 1) {
            return 60;
        }
        return 125 ;
    }
    if (_buttonFlag == 2) {
        return 185;
    }
    if (_buttonFlag == 3) {
        return 44;
    }
    //_buttonflag==4;
    return 92;
    
    
}
#pragma mark - 实现头部视图的代理方法，实现点击事件监听
//点击梦想秀的按钮
- (void)myInfoHeaderViewshowBtnClick:(UIButton *)sender
{
    _buttonFlag = 1;
    
    _showBtn.selected = YES;
    _purseBtn.selected = NO;
    _taskBtn.selected = NO;
    _shoppingCartBtn.selected = NO;
    
    _myShoppingButtomView.hidden = YES;
    _tbView.backgroundColor = [UIColor whiteColor];
    [self.tbView reloadData];
    
    
}
//点击钱包的按钮
- (void)myInfoHeaderViewpuserBtnClick:(UIButton *)sender
{
    _purseBtn = sender;
    _showBtn.selected = NO;
    _purseBtn.selected = YES;
    _taskBtn.selected = NO;
    _shoppingCartBtn.selected = NO;
    
    _buttonFlag = 2;
    
    _myShoppingButtomView.hidden = YES;
    
    _tbView.backgroundColor = [UIColor whiteColor];
    [self.tbView reloadData];
    
}
//点击任务的按钮
- (void)myInfoHeaderViewtaskBtnClick:(UIButton *)sender
{
    _buttonFlag = 3;
    
    _tbView.backgroundColor = kColor(234, 235, 236);
    _taskBtn = sender;
    
    _showBtn.selected = NO;
    _purseBtn.selected = NO;
    _taskBtn.selected = YES;
    _shoppingCartBtn.selected = NO;
    
    _tbView.sectionFooterHeight = 2;
    
    _myShoppingButtomView.hidden = YES;
    [self.tbView reloadData];
    
}
//点击购物车的按钮
- (void)myInfoHeaderViewshoppingCartClick:(UIButton *)sender
{
    _buttonFlag = 4;
    //[self showLoadingFailureViewZFJ:@"购物车空空如也"];
    _tbView.backgroundColor = kColor(234, 235, 236);
    _shoppingCartBtn = sender;
    _showBtn.selected = NO;
    _purseBtn.selected = NO;
    _taskBtn.selected = NO;
    _shoppingCartBtn.selected = YES;
    if (_goodsArr.count == 0) {
        self.myShoppingButtomView.hidden = YES;
        
        //[self showLoadingFailureViewZFJ:@"购物车空空如也"];
    }else
    {
        [self removeLoadingFailureViewZFJ];
        _myShoppingButtomView.hidden = NO;
    }
    _tbView.sectionHeaderHeight = 1;
    
    
    [self.tbView reloadData];
}

//点击编辑的按钮
- (void)myInfoHeaderViewEditBtnClick
{
    PersonalFileViewController *personVc = [[PersonalFileViewController alloc] init];
    
    personVc.title = @"个人档案";
    
    
    personVc.hidesBottomBarWhenPushed = YES;
    
    
    
    [self.navigationController pushViewController:personVc animated:YES];
    
}


#pragma mark - UIImagePickerController代理
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //存储到相册
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - 钱包Cell的点击协议方法
//点击充值的按钮
- (void)MyPurseCellRechargeDidClick
{
   // NSLog(@"点击充值的按钮");
    RechargeViewController *rechargeVc = [[RechargeViewController alloc] init];
    
    rechargeVc.title = @"充值";
    
    rechargeVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rechargeVc animated:YES];
}
//点击兑换咖呗
- (void)MyPurseCellkabaoBtnClick
{
    //NSLog(@"点击兑换咖呗");
    ConversionKabeiController *conVc = [[ConversionKabeiController alloc] init];
    
    conVc.title = @"兑换";
    
    conVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conVc animated:YES];
    
    
}
//点击我的账单
- (void)MyPurseCellMyCheckBtnClick
{
    //NSLog(@"点击我的账单");
    
    MycheckViewController *myCheckVc = [[MycheckViewController alloc] init];
    
    myCheckVc.title = @"我的账单";
    
    myCheckVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myCheckVc animated:YES];
    
}


#pragma mark - 点击全选的按钮
- (IBAction)shoppingButtomSelectAllBtn:(UIButton *)sender {
    /*
     ShoppingCell *cell = (ShoppingCell *)[[sender superview] superview];
     
     
     NSIndexPath * indexPath = [self.tbView indexPathForCell:cell];
     
     DetailGoods *model = _goodsArr[indexPath.row];
     
     model.selected = sender.selected;
     [_selectGoodsArr addObject:model];
     */
    //购物车为空
    if (_goodsArr.count==0) {
        Alert(@"你的购物车空空如也，赶紧去添加吧");
        _selectBtnClick.selected = NO;
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        for (int i = 0; i<_goodsArr.count;i++ ) {
            
            OnlineModel *model = _goodsArr[i];
            
            model.selected = YES;
            [_selectGoodsArr addObject:model];
            
        }
    }
    else
    {
        for (int i = 0; i<_goodsArr.count;i++ ) {
            
            OnlineModel *model = _goodsArr[i];
            
            model.selected = NO;
            [_selectGoodsArr addObject:model];
            
        }
        
        [_selectGoodsArr removeAllObjects];
    }
    
    [_tbView reloadData];
    
}

#pragma 获取删除购物车的接口
- (void)getDeletateShoppingDataWithGoodId:(OnlineModel *)model withIndex:(int)i WithSelectGoodsCount:(NSUInteger)count;
{
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId ,@"goodsid":model.goodsID};
    
   NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid",model.goodsID,@"goodsid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"112" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            
            [_goodsArr removeObjectsInArray:_selectGoodsArr];
            
            //清空选中的数据
            [_selectGoodsArr removeAllObjects];
            if (i == count -1) {
                Alert(@"删除购物车成功");
                //我的主界面删除购物车成功
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleShoopinCateOne" object:nil];
                
            }
            if (_goodsArr.count==0) {
                
                _myShoppingButtomView.hidden = YES;
            }
            [_tbView reloadData];

        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
        }
    }];
    
    
}

#pragma mark - 点击删除的按钮
- (IBAction)deleteBtnClick:(UIButton *)sender {
    
    
     NSUInteger selectGoods = _selectGoodsArr.count;
    if (_selectGoodsArr .count <=0) {
        Alert(@"你没有选中商品");
        return;
    }
    
    else
    {
        for (int i=0; i<_selectGoodsArr.count; i++) {
            
            //[self getDeletateShoppingDataWithGoodId:_selectGoodsArr[i]];
            
           
            //[self getDeletateShoppingDataWithGoodId:[_selectGoodsArr objectAtQYQIndex:i] withIndex:i];
            
            [self getDeletateShoppingDataWithGoodId:[_selectGoodsArr objectAtQYQIndex:i] withIndex:i WithSelectGoodsCount:selectGoods];
        }
    }

    
    NSLog(@"点击了删除按钮");
    
}

#pragma mark - 点击结算的按钮
- (IBAction)settelBtnClick:(UIButton *)sender {
    
    
    if (_selectGoodsArr .count <=0) {
        Alert(@"你没有选中商品");
        return;
    }
    //NSLog(@"点击了结算按钮");
    
    
    SettelViewController *settelVc = [[SettelViewController alloc] init];
    
    settelVc.goodArr = [NSMutableArray arrayWithArray:_selectGoodsArr];
    /*frgvergewrgrgerwgergergergerg*/
    
    [self.navigationController pushViewController:settelVc animated:YES];
    
}
#pragma mark - 本类将要被释放移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end



