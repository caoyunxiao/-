//
//  TCNewDetailViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TCNewDetailViewController.h"
#import "TCNewHomeCell.h"
#import "ExceptionalListViewController.h"
#import "HomeModel.h"
#import "CommentsListViewController.h"
#import "SCNavigationController.h"
#import "leaveWordsModel.h"
#import "RechargeViewController.h"
#import "TCNTableViewFourCell.h"
#import "PersonalHomepageController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "DreamHistoryDetailViewController.h"
#import "AnimailToll.h"              //打赏动画
#import "PersonalFileViewController.h"



@interface TCNewDetailViewController ()<UITextFieldDelegate,TCNewHomeCellDelegate,UIActionSheetDelegate,SCNavigationControllerDelegate,supportButtonClickDelegate,UIAlertViewDelegate,SDCycleScrollViewDelegate>{
    
    
    CosFundPlayer *_cfPlayer;
    UIView *_answerBackView;                //显示视图
    HomeModel *_homeModel;
    GifView *pathView;                      //等待动画
    NSMutableArray *_dataArray;             //留言
    int Newpage;                            //页数
    NSInteger indexPageForClick;            //点击的第几个梦想轨迹
    NSString *PersonUserID;                 //用户ID
    BOOL Videoloaded;                       //视频是否加载完成
    NSDictionary *ProcessDreams;            //发布轨迹字典
    NSString *_videoPath;                   //视频地址
    MBProgressHUD *hud;                     //等待视图
}



@end

@implementation TCNewDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configUI];
    [self requestDataBase:NO];
    
    
    
    [self registerForKeyboardNotifications];
    
    
}

#pragma mark - 请求数据
- (void)requestDataBase:(BOOL)isRefresh
{
    if(self.dreamID != nil)
    {
        __weak TCNewDetailViewController *tcn = self;
//        NSDictionary *wParamDict = @{@"dreamID":_dreamID};
        NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_dreamID,@"dreamID", nil];
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"203" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            NSArray *resultASrr = (NSArray *)resultDict;
            NSDictionary *dict = [resultASrr firstObject];
            [self removeLoadingViewZFJ];
            if([errorCode isEqualToString:@"0"])
            {
                if(_homeModel==nil)
                {
                    _homeModel = [[HomeModel alloc]init];
                }
                [_homeModel setValuesForKeysWithDictionary:dict];
                if(_homeModel!=nil)
                {
                    if (isRefresh) {
                        
                        [hud hide:YES];
                        [tcn.TCNewTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
                    }
                    else
                    {
                        [hud hide:YES];
                        if ([_homeModel.state integerValue]!= 1) {
                            
                            DreamHistoryDetailViewController *oldDream = [[DreamHistoryDetailViewController alloc]init];
                            self.navigationController.navigationBarHidden = NO;
                            oldDream.dreamID = _homeModel.dreamID;
                            oldDream.isDetailGoto = YES;
                            [tcn.navigationController pushViewController:oldDream animated:YES];
                        }
                        /**
                         *  设置播放器
                         */
                       [self setCosFundPlayerAt:self.TCNewTableView.tableHeaderView homeModel:_homeModel];
                       [tcn.TCNewTableView reloadData];
                        
                    }
                }
            }
            else
            {
                //获取数据失败
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            }
        }];
    }
    else
    {
        NSLog(@"梦想ID传值失败！");
    }
}



#pragma mark - 设置配置文件
- (void)configUI
{
    //准备添加梦想轨迹
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddDreamTraject:) name:@"AddDreamTrajectory" object:nil];
    //检测用户充值是否成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshKabei) name:@"rechageSuccess" object:nil];
    indexPageForClick = 0;
    //刷新第一个cell显示的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshFirstCell:) name:@"RefreshFirstCell" object:nil];
    
    _TCNewTableView.delegate = self;
    _TCNewTableView.dataSource = self;
    self.TCNewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setExtraCellLineHidden:self.TCNewTableView];
    _yiJianKaBei = 0;
    isFirstOne = NO;
    Newpage = 1;
    //获取留言数组
    _dataArray = [NSMutableArray array];
    [self.TCNewTableView registerNib:[UINib nibWithNibName:@"TCNTableViewFourCell" bundle:nil] forCellReuseIdentifier:@"TCNTableViewFourCell"];
    
    /**
     *  设置headerView
     *
     *  @return
     */
    self.TCNewTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    
}

#pragma mark -界面马上出现在屏幕上
- (void)viewWillAppear:(BOOL)animated
{
//     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [super viewWillAppear:animated];
    [_cfPlayer.player pause];
    self.navigationController.navigationBarHidden = YES;
    //检测视频是否加载完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VideoloadedNew) name:@"Videoloaded" object:nil];
}

#pragma mark -选中某一个的梦想秀后刷新头部视图
- (void)RefreshFirstCell:(NSNotification *)Not
{
    //停止播放
    [_cfPlayer.player.currentItem removeObserver:_cfPlayer forKeyPath:@"status"];
    [_cfPlayer.player pause];
    _cfPlayer.player = nil;
    for (int i=0; i<self.TCNewTableView.tableHeaderView.subviews.count; i++) {
        
        if (i==self.TCNewTableView.tableHeaderView.subviews.count-1) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:_cfPlayer];
        }
        [[self.TCNewTableView.tableHeaderView.subviews objectAtIndex:i] removeFromSuperview];
    }
    
    indexPageForClick = [Not.object integerValue] - 100;
    [self setCosFundPlayerAt:self.TCNewTableView.tableHeaderView homeModel:_homeModel];
}



#pragma mark -添加图片梦想轨迹数据
- (void)AddDreamTraject:(NSNotification *)dreameID
{
    [self dismissViewControllerAnimated:YES completion:nil];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"发布轨迹中";
    [self.view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    [self.view bringSubviewToFront:hud];
    [self performSelector:@selector(ReleasedTrajectory) withObject:self afterDelay:1];
}

#pragma amrk -发布图片轨迹
- (void)ReleasedTrajectory
{
    //添加梦想轨迹
    int batch = [[[NSUserDefaults standardUserDefaults]objectForKey:@"batch"] intValue]+1;
    [[CosFundForVideoCYX manager]Releasedreamtrajectory:_dreamID Andmediatype:1 Andbatch:batch AndPhotoArray:[PersonInfo sharePersonInfo].uoLoadImageArray AndVideo:nil Completed:^(NSString *errorCode, NSString *resultDict) {
        
        if ([errorCode isEqualToString:@"0"]) {
            
            hud.labelText = @"发布轨迹成功";
            [self requestDataBase:YES];
        }
        else
        {
            hud.labelText = @"发布轨迹失败";
            [hud hide:YES afterDelay:1];
            NSLog(@"%@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
        
    }];
}

#pragma mark -充值成功刷新界面
- (void)RefreshKabei
{
    [self.TCNewTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - 注册检测键盘的通知
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardHide:) name: UIKeyboardWillHideNotification object:nil];
}


#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.row==0)
    {
        return 120;
    }
    else if(indexPath.row==1)
    {
        return 125;
    }
    else if(indexPath.row==2)
    {
        return 276;
    }
    else if(indexPath.row==3)
    {
        return 200;
    }
    else
    {
        return 70;
    }
}



#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if(indexPath.row==0)
    {
        static NSString *str = @"TCNHCellTwo";
        TCNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TCNewHomeCell" owner:self options:nil]objectAtIndex:1];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        if(_homeModel)
        {
            [cell showCellTwoUIViewWithHomeModel:_homeModel];
        }
        return cell;
    }
    else if(indexPath.row==1)
    {
        static NSString *str = @"TCNHCellThree";
        TCNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TCNewHomeCell" owner:self options:nil]objectAtIndex:2];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.CellThreeOneBtn addTarget:self action:@selector(exceptionalClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CellThreeFiveBtn addTarget:self action:@selector(exceptionalClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CellThreeTenBtn addTarget:self action:@selector(exceptionalClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CellThreeYiBaiBtn addTarget:self action:@selector(exceptionalClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CellThreeYiQianBtn addTarget:self action:@selector(exceptionalClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CellThreeYiJianBtn addTarget:self action:@selector(exceptionalClick:) forControlEvents:UIControlEventTouchUpInside];//
//          [cell.CellThreeTopUp addTarget:self action:@selector(rechargeClick:) forControlEvents:UIControlEventTouchUpInside];//去充值
        }
        
        [cell ShowMoneyNumber:_dreamID];
        return cell;
        
    }
    else if(indexPath.row==2)
    {
        static NSString *str = @"TCNHCellFour";
        TCNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        //用户头像点击
        __weak TCNewDetailViewController *tcn = self;
        [cell setPersonImageClickBlock:^(NSString *userID) {
            
            //判断是否是从个人中心进入
            if (self.isMyinfoEnter) {
                
                [tcn.navigationController popToViewController:tcn.navigationController.viewControllers[1] animated:YES];
                return ;
            }
            
            PersonalHomepageController *person = [[PersonalHomepageController alloc]init];
            person.userid = userID;
            person.isCao = YES;
            [tcn.navigationController pushViewController:person animated:YES];
        }];
        //举报按钮点击
        [cell setReportButtonClickBlock:^(NSString * userid) {
            
            PersonUserID = userid;
            [tcn ReportButtonClick];
        }];
        //
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TCNewHomeCell" owner:self options:nil]objectAtIndex:3];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.EndDreamButton addTarget:self action:@selector(EndDreamButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        if(_homeModel)
        {
            [cell showCellFourUIViewWithHomeModel:_homeModel];
        }
        return cell;
    }
    //留言板
    else if(indexPath.row==3)
    {
        
        TCNTableViewFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TCNTableViewFourCell" forIndexPath:indexPath];
        if (cell.datas.count  == 0 ) {
            
          cell.DreamID = _dreamID;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.MessageButton addTarget:self action:@selector(SendMessage) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        static NSString *str = @"TCNHCellSix";
        TCNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TCNewHomeCell" owner:self options:nil]objectAtIndex:5];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.CellSixShare addTarget:self action:@selector(ShareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}



#pragma maark -cell进入复用池前
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {

        [_cfPlayer.player pause];
        [_cfPlayer.playerItem seekToTime:kCMTimeZero];
        _cfPlayer.playButton.alpha = 1.0f;
    }
}

#pragma mark -终结梦想
- (void)EndDreamButtonClick
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定停止梦想?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 100;
    [alertView show];

}

#pragma mark ——举报梦想
- (void)ReportButtonClick
{
    __block UIActionSheet *reportView = [[UIActionSheet alloc]initWithTitle:@"请选择举报理由!" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"色情低俗",@"广告骚扰",@"政治敏感",@"暴力恐怖", nil];
    reportView.tag = 200;
    [reportView showInView:self.view];

}

#pragma mark - 去充值
- (void)rechargeClick:(UIButton *)button
{
    RechargeViewController *rvc = [[RechargeViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}


#pragma mark -终结梦想回调
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //终止
    if (alertView.tag == 100) {
        
        if (buttonIndex == 0) {
            
            //取消
        }
        else if (buttonIndex == 1)
        {
            //确定
            __weak TCNewDetailViewController *tcn = self;
            NSDictionary *Uploaddict = @{@"userid":_homeModel.userID,@"dreamid":_dreamID};
            [RequestEngine UserModulescollegeWithDict:Uploaddict wAction:@"521" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                
                if ([errorCode isEqualToString:@"0"]) {
                    
                    Alert(@"停止梦想成功");
                    [PersonInfo sharePersonInfo].photoCount = 0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"abandonDream" object:nil];
                    [[NSNotificationCenter defaultCenter] removeObserver:self];
                    [tcn.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    Alert(@"停止梦想失败");
                }
                
            }];
        }
    }
    else if (alertView.tag == 101)
    {
        PersonalFileViewController *person = [[PersonalFileViewController alloc]init];
        [self.navigationController pushViewController:person animated:YES];
    }
}



#pragma mark - 分享
- (void)ShareButtonClick:(UIButton *)button
{
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    
#warning 补全信息
    
    NSString *title = @"咖范@宣言";
    NSString *describe = [NSString stringWithFormat:@"%@,快来支持我吧!",_homeModel.name];
    
    NSString *returnUrl = [NSString stringWithFormat:@"http://event.cosfund.com/appShare/shareView.html?dreamId=%@",_homeModel.dreamID];
    
    [self shareWithTitle:title describe:describe image:[UIImage imageNamed:@"logo"] imageURL:nil video:nil returnURL:returnUrl];
    
}

#pragma mark -发送留言
- (void)SendMessage
{
    self.MessageTestField.delegate = self;
    self.MessageTestField.returnKeyType = UIReturnKeySend;
    [self.MessageTestField becomeFirstResponder];
    
}


#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - 打赏
- (void)exceptionalClick:(UIButton *)button
{
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    NSInteger buttonTag = button.tag;
    NSString *exceptional = nil;
    if(buttonTag==200)
    {
        exceptional = @"1";
    }
    else if (buttonTag==201)
    {
        exceptional = @"5";
    }
    else if (buttonTag==202)
    {
        exceptional = @"10";
    }
    else if (buttonTag==203)
    {
        exceptional = @"100";
    }
    else if (buttonTag==204)
    {
        exceptional = @"1000";
    }
    else if (buttonTag==205)
    {
        //        exceptional = @"10000";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YIJIANCAOYUE" object:nil];
        return;
#warning 缺少我支持了
    }
    NSString *userid = [PersonInfo sharePersonInfo].userId;
    NSString *beuid = _homeModel.userID;
    NSString *dreamid = _homeModel.dreamID;
    NSString *nickname = [PersonInfo sharePersonInfo].nickname;
    [self ToSupportTheRequestDataBase:userid beuid:beuid dreamid:dreamid carbei:exceptional nickname:nickname islandscape:NO];
}


#pragma mark - 获取tableView的cell
- (TCNewHomeCell *)cellAtIndexRow:(NSInteger)row andAtSection:(NSInteger) section
{
    TCNewHomeCell * cell = (TCNewHomeCell *)[self.TCNewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    return cell;
}

#pragma mark - 打赏名单
- (void)completeBtnClick
{
    ExceptionalListViewController *evc = [[ExceptionalListViewController alloc]init];
    evc.homeModel = _homeModel;
    [self.navigationController pushViewController:evc animated:YES];
}


#pragma mark - 键盘出现函数
- (void)keyboardWasShown:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _MessageView.frame = CGRectMake(0,ScreenHeight-keyboardSize.height-49, ScreenWidth, 49);
    }];
}
#pragma mark - 键盘关闭函数
-(void)keyboardHide: (NSNotification *)notif
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.1 animations:^{
        
        _MessageView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 49);
    }];
}
#pragma mark - return收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_MessageTestField resignFirstResponder];
    NSString *contentString = _MessageTestField.text;
    if(contentString.length > 0 && contentString!= nil)
    {
        //提交回复的函数
        NSString *userid = [PersonInfo sharePersonInfo].userId;
        NSString *nickname = [PersonInfo sharePersonInfo].nickname;
        [self dreamMessagerequestDataBaseWithuserid:userid nickname:nickname content:contentString];
        _MessageTestField.text = @"";
    }
    else
    {
        [self SHOWPrompttext:@"您没有输入"];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _answerBackView.frame  =CGRectMake(0, ScreenHeight, ScreenWidth, 50);
    }];
    
    return YES;
}

#pragma mark - 添加梦想进度
- (void)addDreamButtonClick:(UIButton *)button
{
    __block UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"添加照片轨迹",@"添加视频轨迹", nil];
    actionSheet.tag = 210;
    [actionSheet showInView:self.view];
}

#pragma mark - actionSheet代理函数
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isMyOldDream"];
    if(actionSheet.tag == 210)
    {
        NSInteger batch = [[[NSUserDefaults standardUserDefaults]objectForKey:@"batch"] integerValue]+1;
        ProcessDreams = @{@"dreamid":_dreamID,@"mediatype":buttonIndex == 0?@(1):@(2),@"batch":@(batch)};
        [PersonInfo sharePersonInfo].isProcessDreams = YES;
        if(buttonIndex==0)
        {
            [PersonInfo sharePersonInfo].isVideo = NO;
            //添加照片轨迹
            ///初始化单例个数
            [PersonInfo sharePersonInfo].photoCount = 0;
            SCNavigationController *nav = [[SCNavigationController alloc] init];
            nav.scNaigationDelegate = self;
            nav.ISME = YES;
            nav.Trajectorydict = ProcessDreams;
            [nav showCameraWithParentController:self];
            
        }
        else if (buttonIndex == 1)
        {

            id<ALBBQuPaiPluginPluginServiceProtocol> sdk = [[TaeSDK sharedInstance] getService:@protocol(ALBBQuPaiPluginPluginServiceProtocol)];
            [sdk setDelegte:(id<QupaiSDKDelegate>)self];
            
            UIViewController *recordController = [sdk createRecordViewControllerWithMaxDuration:20.0
                                                                                        bitRate:800*1000
                                                                    thumbnailCompressionQuality:1.0
                                                                                 watermarkImage:kWaterImage
                                                                              watermarkPosition:QupaiSDKWatermarkPositionTopRight
                                                                                      tintColor:TCColor
                                                                                enableMoreMusic:NO
                                                                                   enableImport:YES
                                                                              enableVideoEffect:YES];
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:recordController];
            navigation.navigationBarHidden = YES;
            [self presentViewController:navigation animated:YES completion:nil];
        }
        else
        {
            //取消
        }
        
    }
    //举报
    else if (actionSheet.tag == 200)
    {
        NSString *Report = nil;
        switch (buttonIndex) {
            case 0:
            {
                Report = @"色情低俗";
            }
                break;
            case 1:
            {
                Report = @"广告骚扰";
            }
                break;
            case 2:
            {
                Report = @"政治敏感";
            }
                break;
            case 3:
            {
                Report = @"暴力恐怖";
            }
                break;
            case 4:
            {
                //取消
            }
                break;
            default:
                break;
        }
        if (buttonIndex != 4) {
            
            //举报
            __weak TCNewDetailViewController *tcn = self;
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:PersonUserID,@"userid",_dreamID,@"dreamid",Report,@"reasons", nil];
            [RequestEngine UserModulescollegeWithDict:dict wAction:@"522" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                
                if ([errorCode isEqualToString:@"0"]) {
                    
                    [tcn SHOWPrompttext:@"举报成功"];
                    
                }else
                {
                    [tcn SHOWPrompttext:@"举报失败"];
                }
            }];
        }
    }
}

#pragma amrk -录制视频回调
- (void)qupaiSDK:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    _videoPath = videoPath;
    [self dismissViewControllerAnimated:YES completion:nil];
        
    if (videoPath == nil) {
        
        return;
    }
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"发布轨迹中";
    hud.tag = 100;
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    [self performSelector:@selector(refreshDatas) withObject:self afterDelay:1];
}

/**
 *  请求发布轨迹接口
 */
- (void)refreshDatas
{
    
    int batch = [[[NSUserDefaults standardUserDefaults]objectForKey:@"batch"] intValue]+1;
    //添加梦想轨迹
    [[CosFundForVideoCYX manager]Releasedreamtrajectory:_dreamID Andmediatype:2 Andbatch:batch AndPhotoArray:nil AndVideo:_videoPath Completed:^(NSString *errorCode, NSString *resultDict) {
        
        if ([errorCode isEqualToString:@"0"]) {
            
            hud.labelText = @"发布轨迹成功";
            NSLog(@"成功");
            [self requestDataBase:YES];
        }
        else
        {
            hud.labelText = @"发布轨迹失败";
            [hud hide:YES afterDelay:1];
            NSLog(@"%@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
        
    }];
}

#pragma mark -视频是否加载完成
- (void)VideoloadedNew
{
    Videoloaded = YES;//视频加载完成
    [_cfPlayer.player play];
    _cfPlayer.playButton.alpha = 0.0f;
    [pathView removeFromSuperview];
    
}

#pragma mark - 设置播放器
- (void)setCosFundPlayerAt:(UIView*)view homeModel:(HomeModel *)homeModel
{
    
    NSArray *array = homeModel.picVid;
    for (NSDictionary *dict in array) {
        
        if ([dict[@"Type"] integerValue] == 2 && [dict[@"Batch"] integerValue] == (indexPageForClick?indexPageForClick:0) ) {
            
            NSString *str = [self getVideoUrlWithKey:dict[@"Url"]];
            NSURL *url = [NSURL URLWithString:str];
            _cfPlayer = [[CosFundPlayer alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) withVideoFileURL:url homeModel:homeModel];
            [view addSubview:_cfPlayer];
            _cfPlayer.clipsToBounds = YES;
            _cfPlayer.delegate = self;
            _cfPlayer.playButton.alpha = 0.0f;
            [_cfPlayer.fullBtn addTarget:self action:@selector(fullBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [_cfPlayer.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            [_cfPlayer addGestureRecognizer:tap];
            GifView *gifView =[[GifView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) filePath:[[NSBundle mainBundle] pathForResource:@"loadImageNew" ofType:@"gif"]];
            [view addSubview:gifView];
            gifView.center = CGPointMake(ScreenWidth/2, ScreenWidth/2);
            pathView = gifView;
            break;
        }
        else if([dict[@"Batch"] integerValue] == (indexPageForClick?indexPageForClick:0) && [dict[@"Type"] integerValue] == 1)
        {
            NSMutableArray *imagearray = [NSMutableArray array];
            for (NSDictionary *ImageDict in array) {
                
                if ([ImageDict[@"Batch"] integerValue] == (indexPageForClick?indexPageForClick:0) && [ImageDict[@"Type"] integerValue] == 1) {
                    [imagearray addObject: [self getImageUrlWithKey:ImageDict[@"Url"]]];
                }
            }
            [_cfPlayer.player pause];
            SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) imageURLStringsGroup:nil]; // 模拟网络延时情景
            cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            [view addSubview:cycleScrollView];
            cycleScrollView.tag = 1000;
            cycleScrollView.dotColor = TCColor; // 自定义分页控件小圆标颜色
            cycleScrollView.delegate = self;
            cycleScrollView.placeholderImage = PlaceholderImage;
            cycleScrollView.autoScrollTimeInterval = 3;
            [self setRankingViewValueZFJ:_homeModel];
            //照片只有一张时不滚动
            if (imagearray.count == 1) {
                
                cycleScrollView.autoScroll = NO;
            }else
            {
                cycleScrollView.autoScroll = YES;
            }
            cycleScrollView.imageURLStringsGroup = imagearray;
            
            break;
        }
    }
}


#pragma mark - 设置右上角排行
- (void)setRankingViewValueZFJ:(HomeModel *)model
{
    RightDownView *_rankingView = [[RightDownView alloc]initWithFrame:CGRectMake(ScreenWidth-165, 30, 100, 100)];
    UIView *view = [self.view  viewWithTag:1000];
    [view addSubview:_rankingView];
    [view bringSubviewToFront:_rankingView];
    NSArray *top3Reward = model.top3Reward;
    if (top3Reward.count == 0) {
        NSLog(@"没有排行榜");
        return;
    }
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 35)];
    [_rankingView addSubview:firstView];
    firstView.backgroundColor = [UIColor clearColor];
    
    UIImageView *firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(160-35-8, 0, 35, 35)];
    firstImage.image = [UIImage imageNamed:@"first.png"];
    [firstView addSubview:firstImage];
    
    UILabel *firstName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160-35-8, 25)];
    firstName.text = [NSString stringWithFormat:@"%@",[top3Reward firstObject][@"nickName"]];
    [firstView addSubview:firstName];
    firstName.textColor = [UIColor whiteColor];
    firstName.font = [UIFont systemFontOfSize:14];
    firstName.textAlignment = NSTextAlignmentRight;
    
    UILabel *firstKaBei = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 160-35-8, 10)];
    firstKaBei.textColor = [UIColor whiteColor];
    firstKaBei.text = [NSString stringWithFormat:@"%@",[top3Reward firstObject][@"amount"]];
    [firstView addSubview:firstKaBei];
    firstKaBei.font = [UIFont systemFontOfSize:10];
    firstKaBei.textAlignment = NSTextAlignmentRight;
    
    
    if (top3Reward.count >1) {
        
        UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 160, 20)];
        UIImageView *secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(160-20-15, 0, 20, 20)];
        secondImage.image = [UIImage imageNamed:@"second.png"];
        [secondView addSubview:secondImage];
        [_rankingView addSubview:secondView];
        UILabel *secondName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160-20-15, 20)];
        secondName.text = top3Reward[1][@"nickName"];
        [secondView addSubview:secondName];
        secondName.textColor = [UIColor whiteColor];
        secondName.font = [UIFont systemFontOfSize:12];
        secondName.textAlignment = NSTextAlignmentRight;
    }
    if (top3Reward.count >2) {
        
        UIImageView *thridImage = [[UIImageView alloc]initWithFrame:CGRectMake(160-20-15, 0, 20, 20)];
        thridImage.image = [UIImage imageNamed:@"third.png"];
        UIView *thridView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, 160, 20)];
        [_rankingView addSubview:thridView];
        [thridView addSubview:thridImage];
        UILabel *thridName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160-20-15, 20)];
        thridName.text = [top3Reward lastObject][@"nickName"];
        [thridView addSubview:thridName];
        thridName.textColor = [UIColor whiteColor];
        thridName.font = [UIFont systemFontOfSize:12];
        thridName.textAlignment = NSTextAlignmentRight;
    }
}



#pragma mark - SDCycleScrollViewDelegate   ..点击图片查看大图
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSMutableArray *imageArr = [NSMutableArray array];
    NSArray *arr = _homeModel.picVid;
    for (NSDictionary *dict in arr) {
        
        if ([dict[@"Type"] integerValue] == 1 && [dict[@"Batch"] integerValue] == (indexPageForClick)) {
            
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:[self getImageUrlWithKey:dict[@"Url"]]];
            [imageArr addObject: photo];
        }
    }
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = imageArr;
    brower.currentPhotoIndex = index;
    [brower show];
    
}



#pragma mark - 全屏
- (void)fullBtnClick
{
    [self Defaultdirection:1];
}

#pragma mark -横屏默认方向
- (void)Defaultdirection:(int)Direction
{
    /**
     *  打赏归零
     */
        _cfPlayer.indexNumber = 0;
        _cfPlayer.imageMove.image = [UIImage imageNamed:@"1KabeiBig"];
        [self.view addSubview:_cfPlayer];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        [UIView animateWithDuration:0.2f animations:^{
            _cfPlayer.backBtn.hidden = NO;
            _cfPlayer.downView.hidden = NO;
            _cfPlayer.rightDownView.hidden = NO;
            _cfPlayer.backBtn.hidden = NO;
            _cfPlayer.fullBtn.hidden = YES;
            
             switch (Direction) {
                case 1://默认向左
                {
                    CGFloat bigWidth = (ScreenHeight - ScreenWidth)/2;
                    _cfPlayer.frame = CGRectMake(-bigWidth, bigWidth, ScreenHeight, ScreenWidth);
                    _cfPlayer.playerLayer.frame = CGRectMake(0, 0, ScreenHeight, ScreenWidth);
                    _cfPlayer.playButton.frame = CGRectMake((_cfPlayer.frame.size.width-60)/2, (_cfPlayer.frame.size.height-60)/2, 60, 60);
                    _cfPlayer.fullBtn.frame = CGRectMake(_cfPlayer.frame.size.width-30, _cfPlayer.frame.size.height-30, 30, 30);
                    [_cfPlayer setTransform:CGAffineTransformMakeRotation(M_PI_2)];
                }
                    break;
                case 2://向右
                {
                    CGFloat bigWidth = (ScreenHeight - ScreenWidth)/2;
                    _cfPlayer.frame = CGRectMake(-bigWidth, bigWidth, ScreenHeight, ScreenWidth);
                    _cfPlayer.playerLayer.frame = CGRectMake(0, 0, ScreenHeight, ScreenWidth);
                    _cfPlayer.playButton.frame = CGRectMake((_cfPlayer.frame.size.width-60)/2, (_cfPlayer.frame.size.height-60)/2, 60, 60);
                    _cfPlayer.fullBtn.frame = CGRectMake(_cfPlayer.frame.size.width-30, _cfPlayer.frame.size.height-30, 30, 30);
                    [_cfPlayer setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
                }
                    break;
                case 3://当前右，向左
                {
                    [_cfPlayer setTransform:CGAffineTransformMakeRotation(M_PI_2)];
                }
                    break;
                case 4://当前左，向右
                {
                    [_cfPlayer setTransform:CGAffineTransformMakeRotation(-M_PI_2)];

                }
                    break;

                default:
                    break;
            }
        } completion:^(BOOL finished) {
            
        }];
    
    self.isFull = !self.isFull;
}


#pragma mark - 退出全屏
- (void)backBtnClick
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    _cfPlayer.backBtn.hidden = YES;
    _cfPlayer.downView.hidden = YES;
    _cfPlayer.rightDownView.hidden = YES;
    _cfPlayer.backBtn.hidden = YES;
    _cfPlayer.fullBtn.hidden = NO;
    
    __weak typeof(self)wself = self;
    [UIView animateWithDuration:0.2f animations:^{
        _cfPlayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
        _cfPlayer.playerLayer.frame = _cfPlayer.frame;
        _cfPlayer.playButton.frame = CGRectMake((_cfPlayer.frame.size.width-60)/2, (_cfPlayer.frame.size.height-60)/2, 60, 60);
        _cfPlayer.fullBtn.frame = CGRectMake(_cfPlayer.frame.size.width-30, _cfPlayer.frame.size.height-30, 30, 30);
        [_cfPlayer setTransform:CGAffineTransformMakeRotation(0)];
    } completion:^(BOOL finished) {
        
        _cfPlayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
        [wself.TCNewTableView.tableHeaderView addSubview:_cfPlayer];
    }];
}

#pragma mark - 播放器点击事件//隐藏或者显示
- (void)singleTap:(UITapGestureRecognizer *)tap
{
    
    if(!_isTap)
    {
        //隐藏
        [UIView animateWithDuration:0.2 animations:^{
            CGRect downViewFrame = _cfPlayer.downView.frame;
            downViewFrame.origin.y = downViewFrame.origin.y + 20;
            _cfPlayer.downView.frame = downViewFrame;
            
            CGRect rightDownView = _cfPlayer.rightDownView.frame;
            rightDownView.origin.x = rightDownView.origin.x + 160;
            rightDownView.origin.y = rightDownView.origin.y + 160;
            _cfPlayer.rightDownView.frame = rightDownView;
            
            CGRect backBtnFrame = _cfPlayer.backBtn.frame;
            backBtnFrame.origin.x = backBtnFrame.origin.x - 40;
            _cfPlayer.backBtn.frame = backBtnFrame;
            
            CGRect barrageViewFrame = _cfPlayer.barrageView.frame;
            barrageViewFrame.origin.x = barrageViewFrame.origin.x - 160;
            _cfPlayer.barrageView.frame = barrageViewFrame;
            
            CGRect rankingViewFrame = _cfPlayer.rankingView.frame;
            rankingViewFrame.origin.x = rankingViewFrame.origin.x + 160;
            _cfPlayer.rankingView.frame = rankingViewFrame;
        }];
    }
    else
    {
        //出现
        [UIView animateWithDuration:0.2 animations:^{
            CGRect downViewFrame = _cfPlayer.downView.frame;
            downViewFrame.origin.y = downViewFrame.origin.y - 20;
            _cfPlayer.downView.frame = downViewFrame;
            
            CGRect rightDownView = _cfPlayer.rightDownView.frame;
            rightDownView.origin.x = rightDownView.origin.x - 160;
            rightDownView.origin.y = rightDownView.origin.y - 160;
            _cfPlayer.rightDownView.frame = rightDownView;
            
            CGRect backBtnFrame = _cfPlayer.backBtn.frame;
            backBtnFrame.origin.x = backBtnFrame.origin.x + 40;
            _cfPlayer.backBtn.frame = backBtnFrame;
            
            CGRect barrageViewFrame = _cfPlayer.barrageView.frame;
            barrageViewFrame.origin.x = barrageViewFrame.origin.x + 160;
            _cfPlayer.barrageView.frame = barrageViewFrame;
            
            CGRect rankingViewFrame = _cfPlayer.rankingView.frame;
            rankingViewFrame.origin.x = rankingViewFrame.origin.x - 160;
            _cfPlayer.rankingView.frame = rankingViewFrame;
            
        }];
        
    }
    _isTap = !_isTap;
}


#pragma mark - 全屏时候的打赏按钮
- (void)supportButtonClick:(NSString *)supportValue
{
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    NSString *userid = [PersonInfo sharePersonInfo].userId;
    NSString *beuid = _homeModel.userID;
    NSString *dreamid = _homeModel.dreamID;
    NSString *nickname = [PersonInfo sharePersonInfo].nickname;
    [self ToSupportTheRequestDataBase:userid beuid:beuid dreamid:dreamid carbei:supportValue nickname:nickname islandscape:YES];
}


/**
 *  打赏成功
 *
 *  @return
 */
#pragma mark - 去支持 - 请求数据
- (void)ToSupportTheRequestDataBase:(NSString *)userid beuid:(NSString *)beuid dreamid:(NSString *)dreamid carbei:(NSString *)carbei nickname:(NSString *)nickname islandscape:(BOOL)landscape
{
    UIView *view = [self.view  viewWithTag:1000];
    if(self.dreamID != nil)
    {
        if ([PersonInfo sharePersonInfo].nickname.length == 0 || [PersonInfo sharePersonInfo].headImg.length == 0 ) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去补充资料", nil];
            alertView.tag = 101;
            [alertView show];
            return;
        }
        __weak TCNewDetailViewController *tcn = self;
        NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_dreamID,@"dreamid", userid,@"userid", beuid,@"beuid", carbei,@"carbei", nickname,@"nickname", nil];
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"204" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            
            if([errorCode isEqualToString:@"0"])
            {
                if ([carbei isEqualToString:@"1"]) {
                    
                    [AnimailToll showRewordanimation:view imageName:@"1KabeiNew" landscape:NO];
                    [AnimailToll showRewordanimation:_cfPlayer imageName:@"1KabeiNew" landscape:landscape];
                }
                if ([carbei isEqualToString:@"5"]) {
                    [AnimailToll showRewordanimation:view imageName:@"5KabeiNew" landscape:NO];
                    [AnimailToll showRewordanimation:_cfPlayer imageName:@"5KabeiNew" landscape:landscape];
                    
                }
                if ([carbei isEqualToString:@"10"]) {
                    
                    [AnimailToll showRewordanimation:view imageName:@"10KabeiNew" landscape:NO];
                    [AnimailToll showRewordanimation:_cfPlayer imageName:@"10KabeiNew" landscape:landscape];
                }
                if ([carbei isEqualToString:@"100"]) {
                    
                    [AnimailToll showRewordanimation:view imageName:@"100KabeiNew" landscape:NO];
                    [AnimailToll showRewordanimation:_cfPlayer imageName:@"100KabeiNew" landscape:landscape];
                }
                if ([carbei isEqualToString:@"1000"]) {
                    
                    [AnimailToll showRewordanimation:view imageName:@"100KabeiNew" landscape:NO];
                    [AnimailToll showRewordanimation:_cfPlayer imageName:@"1000KabeiNew" landscape:landscape];
                }
                
                MBProgressHUD *hudnew = [MBProgressHUD showHUDAddedTo:tcn.view animated:YES];
                //判断是否在横屏状态下
                if (landscape) {
                    
                    [hudnew setTransform:_cfPlayer.transform];
                    
                }
                hudnew.labelText = [NSString stringWithFormat:@"打赏%@咖贝成功",carbei];
                hudnew.margin = 10.f;
                hudnew.mode = MBProgressHUDModeText;
                hudnew.removeFromSuperViewOnHide = YES;
                [hudnew hide:YES afterDelay:0.5f];
                
                //刷新数据
                NSArray *array = (NSArray *)resultDict;
                TCNewHomeCell *cell = [self cellAtIndexRow:2 andAtSection:0];
                CGFloat raiseAmount = [array[0][@"raiseAmount"] floatValue] +[carbei floatValue];
                CGFloat NeededMoney = [cell.NeededMoney floatValue];
                CGFloat floatNumber = raiseAmount/NeededMoney;
                [cell.setProgress setProgress:floatNumber*100 animated:YES];
                cell.exceptionalPeople.text = [NSString stringWithFormat:@"打赏次数:%@次",array[0][@"raiseCount"]];
                cell.hasDown.text = [NSString stringWithFormat:@"已完成:%ld咖贝",(long)[array[0][@"raiseAmount"]integerValue]+[carbei integerValue]];
                
                [self.TCNewTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                [self.TCNewTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                //刷新个人主页余额
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMyinfoKabei" object:nil];
                
            }
            else if ([errorCode isEqualToString:@"3021"] || [errorCode isEqualToString:@"3003"])
            {
                Alert(@"咖贝余额不足");
            }
            else
            {
                //获取数据失败
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
                Alert(@"打赏失败");
            }
        }];
    }
    else
    {
        NSLog(@"梦想ID传值失败！");/*sssssssd222222222222222222222222*/
    }
}

#pragma mark - 收藏 - 请求数据
- (void)collectionRequestDataBase
{
    if(self.dreamID != nil)
    {
        NSString *_scuid;
//        NSDictionary *wParamDict = @{@"dreamid":_dreamID,@"scuid":_scuid};
        NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_dreamID,@"dreamid", _scuid,@"scuid", nil];
        
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"205" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            if([errorCode isEqualToString:@"0"])
            {
            }
            else
            {
                //获取数据失败
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            }
        }];
    }
    else
    {
        NSLog(@"梦想ID传值失败！");
    }
}

#pragma mark - 我支持的人 - 请求数据
- (void)ISupportThePeopleRequestDataBase
{
    if(self.dreamID != nil)
    {
        NSString *_userid;
//        NSDictionary *wParamDict = @{@"userid":_userid};
        
        NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_userid,@"userid", nil];
        
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"206" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            if([errorCode isEqualToString:@"0"])
            {
            }
            else
            {
                //获取数据失败
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            }
        }];
    }
    else
    {
        NSLog(@"梦想ID传值失败！");
    }
}

#pragma mark - 梦想留言（504）
- (void)dreamMessagerequestDataBaseWithuserid:(NSString *)userid nickname:(NSString *)nickname content:(NSString *)content
{
//    NSDictionary *wParamDict = @{@"userid":userid,@"dreamid":_dreamID,@"nickname":nickname,@"content":content};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid", _dreamID,@"dreamid", nickname,@"nickname",content,@"content", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"504" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            //增加留言板数据
            leaveWordsModel *model = [[leaveWordsModel alloc]init];
            model.nickName = [[PersonInfo sharePersonInfo] nickname];
            model.content = content;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SendMessageSuccess" object:model];
            [self SHOWPrompttext:@"发布留言成功"];
            
        }
        else
        {
            Alert(@"留言失败,请稍后再试");
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
}


#pragma mark -返回按钮
- (IBAction)backButtonClick:(UIButton *)sender {
    
    //停止播放
    [_cfPlayer.player.currentItem removeObserver:_cfPlayer forKeyPath:@"status"];
    [_cfPlayer.player pause];
    [_cfPlayer.playerItem seekToTime:kCMTimeZero];
    //释放所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TCNewHomeCell *cell = [self cellAtIndexRow:0 andAtSection:0];
    //清空上一次选中的轨迹状态
    cell.indexNumber = 0;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -检测当前屏幕旋转方向
- (void)orientationChanged:(NSNotification *)note  {
    
    
    //判断当前现在的梦想是否是视频
    NSArray *array = _homeModel.picVid;
    for (NSDictionary *dict in array) {
        
        if ([dict[@"Type"] integerValue] == 1 && [dict[@"Batch"] integerValue] == indexPageForClick) {
            
            return;
        }
    }
    //如果是视频判断是否加载完成
    if (!Videoloaded) {
        
        NSLog(@"......视频加载未完成");
        return;
    }
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationPortrait:
            
            [self backBtnClick];
            NSLog(@"下");
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            [self backBtnClick];
            NSLog(@"上");
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            
            NSLog(@"%f",_cfPlayer.bounds.size.width);
            if (_cfPlayer.bounds.size.width == ScreenHeight) {
                
                
                [self Defaultdirection:3];
            }
            else
            {
                [self Defaultdirection:1];
            }
            NSLog(@"右");
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"左");
            
             NSLog(@"%f",_cfPlayer.bounds.size.width);
            if (_cfPlayer.bounds.size.width == ScreenHeight) {
                
                [self Defaultdirection:4];
            }
            else
            {
                [self Defaultdirection:2];
            }
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
            
            break;
        default:
            break;
    }
}


#pragma mark -页面即将消失前
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    /**
     *  释放检测视频释放完成的通知
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Videoloaded" object:nil];
    [_cfPlayer.player pause];
    _cfPlayer.playButton.alpha = 1.0f;
    [_cfPlayer.playerItem seekToTime:kCMTimeZero];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UIDevice *device = [UIDevice currentDevice];
    [nc removeObserver:self name:UIDeviceOrientationDidChangeNotification object:device];
}

//
//#pragma mark -界面消失之后
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//}


#pragma mark -界面渲染完成
- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:YES];
    /**
     *  检测设备旋转方向
     */
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:device];
    

}








@end
