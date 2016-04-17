//
//  PublishedPhotosViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "PublishedPhotosViewController.h"
#import "PublishedPhotosCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "DreamLabelModel.h"
#import "ShowOneImageViewController.h"


#define TitleLength       14
#define DescribeStrLength 140
#define SloganLength      9

@interface PublishedPhotosViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,showGigImageViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    NSMutableArray *_dreamLabelArr;
    CosFundPlayer *_cfPlayer;
    PublishedPhotosCell *pubcell;
    BOOL isFirstOne;
    CGRect oldFrame;
    NSMutableArray *_completeDream;
    MBProgressHUD *hudNew;//等待视图
    UINavigationController *navigation; //重新录制的导航栏
}

@property (weak, nonatomic) IBOutlet UITableView *PPVTableView;

@end

@implementation PublishedPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uiConfig];
    [self getDreamLabelrequestDataBase];
    [self getDreamSuccessTime];
    
}

- (void)uiConfig
{
    self.title = @"编辑梦想秀";
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationController.navigationBarHidden = NO;
    self.PPVTableView.delegate = self;
    self.PPVTableView.dataSource = self;
    self.PPVTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"TCBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(BackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    _dreamLabelArr = [[NSMutableArray alloc]init];
    _lablelistArr = [[NSMutableArray alloc]init];
    _upLoadResultArr = [[NSMutableArray alloc]init];
    _newImageArray = [NSMutableArray arrayWithArray:self.imageArray];
    _photoCount = [PersonInfo sharePersonInfo].photoCount;
    if([self.resourceType isEqualToString:@"photo"])
    {
        _mediatype = @"1";
    }
    else if([self.resourceType isEqualToString:@"video"])
    {
        _mediatype = @"2";
    }
    else
    {
        _mediatype = @"3";
    }
    
    //封面照片ObjectKey
    _coverStr = [BaseViewController getOSSObjectKeyWithtype:@"png"];
    //初始化梦想周期数组
    _completeDream = [NSMutableArray array];
    
}
/**
 *  返回
 */
- (void)BackClick
{
    [PersonInfo sharePersonInfo].photoCount = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -获取梦想完成周期
- (void)getDreamSuccessTime
{
    [RequestEngine UserModulescollegeWithDict:nil wAction:@"900" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if ([errorCode isEqualToString:@"0"]) {
            
            NSArray *array = (NSArray *)resultDict;
            [_completeDream addObjectsFromArray:array];
        }
        
    }];
}

#pragma mark - 获取梦想标签（503）
- (void)getDreamLabelrequestDataBase
{
    [RequestEngine UserModulescollegeWithDict:nil wAction:@"503" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            NSLog(@"梦想标签%@",resultDict);
            NSArray *resultArr = (NSArray *)resultDict;
            for (NSDictionary *dict in resultArr)
            {
                DreamLabelModel *model = [[DreamLabelModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dreamLabelArr addObject:model];
            }
            [self.PPVTableView reloadData];
            
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"获取梦想标签失败,请稍后再试....");
        }
    }];
}

#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 56;
    }
    else if(indexPath.row==1)
    {
        return 140;
    }
    //六张照片
    else if(indexPath.row==2)
    {
        if([self.resourceType isEqualToString:@"photo"])
        {
            CGFloat width = ((ScreenWidth - 16)-4)/3;
            if(_newImageArray.count<3)
            {
                return width+46;
            }
            else
            {
                return width*2+2+46;
            }
        }
        else if([self.resourceType isEqualToString:@"video"])
        {
            CGFloat width = ScreenWidth-16;
            return width*320/568 + 46;
        }
        else
        {
            return 0;
        }
    }
    else if(indexPath.row==3)
    {
        return 137;
    }
    else if(indexPath.row==4)
    {
        return 56;
    }
    //梦想标签
    else if(indexPath.row==5)
    {
        CGFloat width = 60;
        NSInteger count = (ScreenWidth-60)/(width+3);
        NSInteger a = _dreamLabelArr.count%count;
        NSInteger b = _dreamLabelArr.count/count;
        if(a!=0)
        {
            b ++;
        }
        return 18*b+100;
    }
    else if(indexPath.row==6)
    {
        return 130;
        
        
    }
    else if(indexPath.row==7)
    {
        return 60;
    }
    else if(indexPath.row==8)
    {
        return 75;
    }
    else if(indexPath.row==9)
    {
        return 60;
    }
    else
    {
        return 0.01;
    }
}


#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //梦想标题
    if(indexPath.row==0)
    {
        static NSString *str = @"PPhCellOne";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:0];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.PPCOneTitle.delegate = self;
            cell.PPCOneTitle.tag = 70;
            [cell.PPCOneTitle addTarget:self action:@selector(UITextFieldChange:) forControlEvents:UIControlEventEditingChanged];
        }
        return cell;
    }
    //封面照片
    else if(indexPath.row==1)
    {
        static NSString *str = @"PPhCellTwo";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:1];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.PPCTwoBigImage.image = [_newImageArray firstObject];
            _homePagePic = [_newImageArray firstObject];
            cell.delegate = self;
        }
        return cell;
    }
    //六张照片  或者 视频
    else if(indexPath.row==2)
    {
        static NSString *str = @"PPhCellThree";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:2];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //视频播放按钮
            [cell setPlayerButtonClick:^{
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全屏播放",@"重拍视频", nil];
                actionSheet.tag = 112;
                [actionSheet showInView:self.view];
            }];
            pubcell = cell;
            cell.delegate = self;
        }
        if([self.resourceType isEqualToString:@"photo"])
        {
            if(_newImageArray.count>0)
            {
                [cell showUIViewWithImageArray:_newImageArray];
            }
        }
        else if([self.resourceType isEqualToString:@"video"])
        {
            if(self.videoFileURL)
            {
                [self setCosFundPlayerAt:cell Videofilepath:self.videoFileURL];
            }
        }
        return cell;
    }
    //梦想描述
    else if(indexPath.row==3)
    {
        static NSString *str = @"PPhCellFour";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:3];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.PPCFourDescribe.delegate = self;
            cell.PPCFourDescribe.tag = 71;
        }
        return cell;
    }
    //拉赞口号
    else if(indexPath.row==4)
    {
        static NSString *str = @"PPhCellFive";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:4];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.PPCFiveSlogan.delegate = self;
            cell.PPCFiveSlogan.tag = 72;
            [cell.PPCFiveSlogan addTarget:self action:@selector(UITextFieldChange:) forControlEvents:UIControlEventEditingChanged];
        }
        return cell;
    }
    //梦想标签
    else if(indexPath.row==5)
    {
        static NSString *str = @"PPhCellSix";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:5];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        if(_dreamLabelArr.count>0)
        {
            [cell showAllLabelViewWithLabelArr:_dreamLabelArr];
        }
        return cell;
    }
    //梦想完成时间
    else if(indexPath.row==6)
    {
        static NSString *str = @"PPhCellSeven";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:6];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.PPCSevenOneWeek addTarget:self action:@selector(timerWeekClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.PPCSevenTwoWeek addTarget:self action:@selector(timerWeekClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.PPCSevenThreeWeek addTarget:self action:@selector(timerWeekClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.PPCSevenFourWeek addTarget:self action:@selector(timerWeekClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    //梦想达成金额
    else if(indexPath.row==7)
    {
        static NSString *str = @"PPhCellEight";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:7];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
           
        }
        return cell;
    }
    //提示
    else if(indexPath.row==8)
    {
        static NSString *str = @"PPhCellNine";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:8];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    //发布梦想
    else if(indexPath.row==9)
    {
        static NSString *str = @"PPhCellTen";
        PublishedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PublishedPhotosCell" owner:self options:nil]objectAtIndex:9];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.PPCTenBtn addTarget:self action:@selector(PPCTenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    else
    {
        return nil;
    }
}



#pragma mark - 设置播放器
- (void)setCosFundPlayerAt:(PublishedPhotosCell*)cell Videofilepath:(NSURL *)videopath
{
    CGFloat width = ScreenWidth-16;
    if(isFirstOne)
    {
        return;
    }
    isFirstOne = YES;
    _cfPlayer = [[CosFundPlayer alloc]initWithFrame:CGRectMake(0, 0, width, width*320/568) withVideoFileURL:videopath homeModel:nil];
    _cfPlayer.clipsToBounds = YES;
    _cfPlayer.fullBtn.hidden = YES;
    _cfPlayer.barrageView.hidden = YES;
    _cfPlayer.isplayer = YES;
    oldFrame = _cfPlayer.frame;
    [cell.PPCThreeView addSubview:_cfPlayer];
    [_cfPlayer.playButton addTarget:self action:@selector(PLayerClick) forControlEvents:UIControlEventTouchUpInside];
    [_cfPlayer.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
}

#pragma mark -全屏状态下退出全屏
- (void)backBtnClick
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    _cfPlayer.backBtn.hidden = YES;
    _cfPlayer.downView.hidden = YES;
    _cfPlayer.rightDownView.hidden = YES;
    _cfPlayer.backBtn.hidden = YES;
    _cfPlayer.fullBtn.hidden = YES;
    [pubcell.PPCThreeView addSubview:_cfPlayer];
    
//    [self.PPVTableView beginUpdates];
    
    CGFloat width = ScreenWidth-16;
    self.PPVTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    [UIView animateWithDuration:0.2f animations:^{
        
        _cfPlayer.frame = CGRectMake(0,0, width*320/568, width);
        _cfPlayer.center = CGPointMake(pubcell.PPCThreeView.frame.size.width/2, pubcell.PPCThreeView.frame.size.height/2);
        _cfPlayer.playButton.frame = CGRectMake(0, 0, 60, 60);
        _cfPlayer.playButton.center = CGPointMake(_cfPlayer.bounds.size.width/2, _cfPlayer.bounds.size.height/2);
        [_cfPlayer setTransform:CGAffineTransformMakeRotation(0)];
        
    }];
}


#pragma mark -播放按钮点击
- (void)PLayerClick
{
    
    if (_cfPlayer.frame.size.width == ScreenWidth && _cfPlayer.frame.size.height == ScreenHeight) {
        
        [_cfPlayer.playerItem seekToTime:kCMTimeZero];
        [_cfPlayer.player play];
        _cfPlayer.playButton.alpha = 0.f;
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全屏播放",@"重拍视频", nil];
    actionSheet.tag = 112;
    [actionSheet showInView:self.view];
}

#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    
}


#pragma mark - 梦想标签点击事件
- (void)dreamLabelTapClick:(UIButton *)button
{
    
    if (_lablelistArr.count >=3&&button.selected==NO) {
        Alert(@"梦想标签不能超过3个");
        return;
    }
    button.selected = !button.selected;
    
    DreamLabelModel *model =[_dreamLabelArr objectAtQYQIndex:button.tag];
    
    
    if (button.selected == YES) {
        [button setBackgroundColor:[UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1]];
        model.isSelect = button.selected;
        
        [_lablelistArr addObject:model];
        
    }
    else
    {
        model.isSelect = NO;
        button.backgroundColor = [UIColor lightGrayColor];
        [_lablelistArr removeObject:model];
    }
    
    //梦想标签
    PublishedPhotosCell *cell = [self cellAtIndexRow:5 andAtSection:0];
    if(_lablelistArr.count>0)
    {
        NSMutableArray *arrstring = [NSMutableArray array];
        for (DreamLabelModel *model in _lablelistArr) {
            
            cell.PPCSixImage.image = [UIImage imageNamed:@"SV_Chose"];
            
            [arrstring addObject:model.lableID];
            
        }
        _lablelist = [arrstring componentsJoinedByString:@","];
    }
    else
    {
        cell.PPCSixImage.image = [UIImage imageNamed:@"SV_Chose_no"];
        _lablelist = @"";
    }
}

#pragma mark - 输入框发生变化
- (void)UITextFieldChange:(UITextField *)textField
{
    NSInteger tag = textField.tag;
    NSString *textStr = textField.text;
    if(tag == 70)
    {
        //标题
        PublishedPhotosCell *cell = [self cellAtIndexRow:0 andAtSection:0];
        if(textStr.length>0)
        {
            cell.PPCOneImage.image = [UIImage imageNamed:@"SV_Chose"];
        }
        else
        {
            cell.PPCOneImage.image = [UIImage imageNamed:@"SV_Chose_no"];
        }
        _title = textStr;
        
    }
    else if (tag == 72)
    {
        //拉赞口号
        PublishedPhotosCell *cell = [self cellAtIndexRow:4 andAtSection:0];
        if(textStr.length>0)
        {
            cell.PPCFiveImage.image = [UIImage imageNamed:@"SV_Chose"];
        }
        else
        {
            cell.PPCFiveImage.image = [UIImage imageNamed:@"SV_Chose_no"];
        }
        _slogan = textStr;
    }
}

#pragma mark - 输入框发生改变
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger tag = textView.tag;
    NSString *textStr = textView.text;
    if(tag==71)
    {
        //梦想描述
        PublishedPhotosCell *cell = [self cellAtIndexRow:3 andAtSection:0];
        if(textStr.length>0)
        {
            cell.PPCFourImage.image = [UIImage imageNamed:@"SV_Chose"];
        }
        else
        {
            cell.PPCFourImage.image = [UIImage imageNamed:@"SV_Chose_no"];
        }
        _describeStr = textStr;
    }
}

#pragma mark - 获取tableView的cell
- (PublishedPhotosCell *)cellAtIndexRow:(NSInteger)row andAtSection:(NSInteger)section
{
    PublishedPhotosCell * cell = (PublishedPhotosCell *)[_PPVTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    return cell;
}

#pragma mark - 点击一张图片
- (void)showOneGigImageView:(NSInteger)index
{
    [self.view endEditing:YES];
    _indexImage = index;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"设置成封面照片",@"查看照片",@"删除", nil];
    actionSheet.tag = 110;
    [actionSheet showInView:self.view];
}
#pragma mark - 选择照相或者照片
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 110)
    {
        if(buttonIndex==0)
        {

            //设置成封面照片
            PublishedPhotosCell *cell = [self cellAtIndexRow:1 andAtSection:0];
            cell.PPCTwoView.hidden = YES;
//            cell.PPCTwoBigImage.image = _newImageArray[_indexImage];
//            _homePagePic = _newImageArray[_indexImage];
            cell.PPCTwoBigImage.image = [_newImageArray objectAtQYQIndex:_indexImage];
            _homePagePic = [_newImageArray objectAtQYQIndex:_indexImage];
            
            
            cell.PPCTwoImage.image = [UIImage imageNamed:@"SV_Chose"];
        }
        else if(buttonIndex==1)
        {
            //查看照片
            [self showBigImageView:_indexImage];
//            NSMutableArray *imageArr = [NSMutableArray array];
//            for (int i=0; i<_newImageArray.count; i++) {
//                
//                MJPhoto *photo = [[MJPhoto alloc] init];
//                photo.image = _newImageArray[i];
//                [imageArr addObject: photo];
//            }
//            MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
//            brower.photos = imageArr;
//            brower.currentPhotoIndex = buttonIndex;
//            [brower show];
            
        }
        else if(buttonIndex==2)
        {
            //删除
#pragma mark - 删除
            [_newImageArray removeObjectAtIndex:_indexImage];
//            [self.PPVTableView reloadData];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:2 inSection:0];
            [self.PPVTableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            
            [PersonInfo sharePersonInfo].photoCount = _newImageArray.count;
            _photoCount = [PersonInfo sharePersonInfo].photoCount;
        }
        else
        {
            //取消
            NSLog(@"444444");
        }
    }
    else if(actionSheet.tag == 111)
    {
        UIImagePickerController *pc = [[UIImagePickerController alloc]init];
        pc.delegate = self;
        if(buttonIndex==0)//拍照
        {
            //设置资源类型
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [pc setSourceType:UIImagePickerControllerSourceTypeCamera];
                pc.allowsEditing = NO;
                [self presentViewController:pc animated:YES completion:nil];
            }
            else
            {
                Alert(@"主人,相机无法使用哦");
            }
        }
        else if (buttonIndex==1)//选择
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                [pc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                //设置允许编辑
                pc.allowsEditing = NO;
                [self presentViewController:pc animated:YES completion:nil];
            }
            else{
                
                Alert(@"主人,无法访问相册哦");
            }
        }
        else if (buttonIndex==2)//取消
        {
        }
    }
    else if (actionSheet.tag == 112)
    {
        //全屏播放
        if (buttonIndex == 0) {
            
            CGFloat bigWidth = (ScreenHeight - ScreenWidth)/2;
            [self.view addSubview:_cfPlayer];
            self.navigationController.navigationBar.hidden = YES;
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            [UIView animateWithDuration:0.2f animations:^{
                _cfPlayer.backBtn.hidden = NO;
                _cfPlayer.downView.hidden = NO;
                _cfPlayer.rightDownView.hidden = YES;
                _cfPlayer.backBtn.hidden = NO;
                _cfPlayer.barrageView.hidden = YES;
                _cfPlayer.rankingView.hidden = YES;
                _cfPlayer.fullBtn.hidden = YES;
                _cfPlayer.downView.hidden = YES;
                
                CGRect frame = CGRectMake(-bigWidth, bigWidth, ScreenHeight, ScreenWidth);
                _cfPlayer.frame = frame;
                _cfPlayer.playerLayer.frame = CGRectMake(0, 0, ScreenHeight, ScreenWidth);
                _cfPlayer.playButton.frame = CGRectMake((_cfPlayer.frame.size.width-60)/2, (_cfPlayer.frame.size.height-60)/2, 60, 60);
                [_cfPlayer setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            } completion:^(BOOL finished) {
                
                [_cfPlayer.playerItem seekToTime:kCMTimeZero];
                [_cfPlayer.player play];
                _cfPlayer.playButton.alpha = 0.f;
                
            }];
        }
        //重拍视频
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
            
            navigation = [[UINavigationController alloc] initWithRootViewController:recordController];
            navigation.navigationBarHidden = YES;
            [self presentViewController:navigation animated:YES completion:nil];
        }
    }
    
}


#pragma amrk -录制视频回调
- (void)qupaiSDK:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    if (videoPath == nil) {
        
        return;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self dismissViewControllerAnimated:YES completion:nil];

    PublishedPhotosCell *cell = [self cellAtIndexRow:2 andAtSection:0];
    [self setCosFundPlayerAt:cell Videofilepath:[NSURL fileURLWithPath:videoPath]];
    NSLog(@"2Qupai SDK compelete %@",videoPath);
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
    }
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
}




#pragma mark - 查看照片
- (void)showBigImageView:(NSInteger)index
{
    UIImage *image = [_newImageArray objectAtQYQIndex:index];
    ShowOneImageViewController *svc = [[ShowOneImageViewController alloc]init];
    svc.bigImage = image;
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:svc];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate相关
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //判断选择完的资源是image还是media
    NSString *str = [info objectForKey:UIImagePickerControllerMediaType];
    if ([str isEqualToString:(NSString *)kUTTypeImage])
    {
        //UIImagePickerControllerOriginalImage
        //UIImagePickerControllerEditedImage
        UIImage *userImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self dismissViewControllerAnimated:YES completion:nil];
        if(userImage)
        {
            if(!_isCoverImage)
            {
                [_newImageArray addObject:userImage];
                
                _photoCount ++;
                
                [PersonInfo sharePersonInfo].photoCount = _photoCount;
                
                [self.PPVTableView reloadData];
            }
            else
            {
                //设置成封面照片
                PublishedPhotosCell *cell = [self cellAtIndexRow:1 andAtSection:0];
                
                cell.PPCTwoView.hidden = YES;
                
                cell.PPCTwoBigImage.image = userImage;
                
                _homePagePic = userImage;
                
                cell.PPCTwoImage.image = [UIImage imageNamed:@"SV_Chose"];
            }
        }
        else
        {
            //
        }
        
    }
    else
    {
        Alert(@"主人,头像上传失败了哦");
    }
}

#pragma mark - 不足六张 再次添加一张
- (void)addOneImageButtonClick:(UIButton *)button
{
    [self.view endEditing:YES];
    _isCoverImage = NO;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    actionSheet.tag = 111;
    [actionSheet showInView:self.view];
}

#pragma mark - 选择梦想完成时间
- (void)timerWeekClick:(UIButton *)button
{
    
    
    PublishedPhotosCell *timecell = [self cellAtIndexRow:7 andAtSection:0];
    for (NSDictionary *dict in _completeDream) {
        
        NSLog(@"%@",dict[@"name"]);
        if ([dict[@"name"] isEqualToString:button.currentTitle]) {
            
            
            timecell.DayNumber.text = button.currentTitle;
            timecell.NeedKabei.text = [NSString stringWithFormat:@"%@咖贝",dict[@"caBei"]];
            _minamount = dict[@"caBei"];
        }
    }
    
    NSInteger index = button.tag - 100;
    PublishedPhotosCell *cell = [self cellAtIndexRow:6 andAtSection:0];
    NSArray *buttonArr = @[cell.PPCSevenOneWeek,cell.PPCSevenTwoWeek,cell.PPCSevenThreeWeek,cell.PPCSevenFourWeek];
    for (int i = 0; i<buttonArr.count; i++)
    {
        UIButton *button = [buttonArr objectAtQYQIndex:i];
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1].CGColor;
        button.backgroundColor = [UIColor whiteColor];
    }
    UIButton *selectButton = [buttonArr objectAtQYQIndex:index];
    selectButton.layer.borderWidth = 1.0;
    selectButton.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1].CGColor;
    selectButton.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1];
    
    [self getEndtime:button.currentTitle];
    //梦想描述
    if(_endtime.length>0)
    {
        cell.PPCSevenImage.image = [UIImage imageNamed:@"SV_Chose"];
    }
    else
    {
        cell.PPCSevenImage.image = [UIImage imageNamed:@"SV_Chose_no"];
    }
}

- (void)getEndtime:(NSString *)currentTitle
{
    NSInteger dis = [currentTitle integerValue];
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    
    if(dis!=0)
    {
        NSTimeInterval oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis];
    }
    else
    {
        theDate = nowDate;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:theDate];
    _endtime = strDate;
    
}


#pragma mark - 首页图片点击事件
- (void)PPCTwoBigImageClick
{
    [self.view endEditing:YES];
    _isCoverImage = YES;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    actionSheet.tag = 111;
    [actionSheet showInView:self.view];
}
#pragma mark - 发布梦想
- (void)PPCTenBtnClick:(UIButton *)button
{
    if([self.resourceType isEqualToString:@"photo"])
    {
        
        _medialist = self.resourceType;
    }
    else if([self.resourceType isEqualToString:@"video"])
    {

        _medialist = self.resourceType;
    
    }
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    if(_title.length<=0||_title.length>TitleLength)
    {
        NSString *titleAlert = [NSString stringWithFormat:@"梦想标题长度在1到%d之间",TitleLength];
        Alert(titleAlert);
        return;
    }
    if(_homePagePic==nil)
    {
        Alert(@"请选择一张封面照");
        return;
    }
    if(_medialist.length==0)
    {
        Alert(@"发布梦想至少上传一张照片或者一段视频");
        return;
    }
    if(_describeStr.length<=0||_describeStr.length>DescribeStrLength)
    {
        NSString *describeAlert = [NSString stringWithFormat:@"梦想描述长度在1到%d之间",DescribeStrLength];
        Alert(describeAlert);
        return;
    }
    
    if (_slogan.length <= 0) {
        
         _slogan = @"请支持我吧";
    }
    else
    {
        if(_slogan.length<=0||_slogan.length>SloganLength)
        {
            NSString *sloganAlert = [NSString stringWithFormat:@"梦想口号长度在1到%d之间",SloganLength];
            Alert(sloganAlert);
            return;
        }
    }
    if(_lablelist.length<=0)
    {
        Alert(@"至少选择一个梦想标签");
        return;
    }
    if(_endtime.length<=0)
    {
        Alert(@"请选择梦想完成日期");
        return;
    }

    //发布梦想
    hudNew = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudNew.labelText = @"发布梦想中";
    [self.view addSubview:hudNew];
    hudNew.removeFromSuperViewOnHide = YES;
    [self.view bringSubviewToFront:hudNew];
    [self performSelector:@selector(upLoadDream) withObject:self afterDelay:1];
//    [self upLoadDream];

}

#pragma mark -发布梦想
- (void)upLoadDream
{
    //判断是否是视频
    int mediaType = 0;
    if ([_resourceType isEqualToString:@"photo"]) {
        
        mediaType = 1;
        
    }else if ([_resourceType isEqualToString:@"video"])
    {
        mediaType = 2;
    }
    [[CosFundForVideoCYX manager]Releasedreamscover:_homePagePic Andmediatype:mediaType Anduserid:[PersonInfo sharePersonInfo].userId Andtitle:_title Anddescribe:_describeStr Andslogan:_slogan Andminamount:_minamount Andendtime:_endtime Andlablelist:_lablelist AndphotoArray:(mediaType == 1)?_imageArray:nil orVideopath:mediaType == 2?_VideoString:nil Completed:^(NSString *errorCode, NSString *resultDict) {
        
        if ([errorCode isEqualToString:@"0"]) {
            
            hudNew.labelText = @"发布梦想成功";
            [hudNew hide:YES afterDelay:1];
//            [self dismissViewControllerAnimated:YES completion:nil];
//            [hudNew hide:YES afterDelay:1];
             [self performSelector:@selector(BackNavigation) withObject:self afterDelay:1];
            //发送梦想成功的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PublishDreamSuccess" object:nil];
            

        }else
        {
            hudNew.labelText = @"发布梦想失败";
          [hudNew hide:YES afterDelay:1];
//            [hudNew hide:YES];
//            [self dismissViewControllerAnimated:YES completion:nil];
//            [self dismissViewControllerAnimated:YES completion:nil];
            [self performSelector:@selector(BackNavigation) withObject:self afterDelay:1];
            
        }

    }];
}


#pragma mark -返回上一层
- (void)BackNavigation
{
    [PersonInfo sharePersonInfo].photoCount = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 上传图片数组
- (void)uploadImageWith:(NSArray *)ImageArray
{
    if(ImageArray.count<=0)
    {
        return;
    }
    for (int i = 0; i<ImageArray.count; i++)
    {
// NSString *ObjectKey = [BaseViewController getOSSObjectKey:i];
        
        [_upLoadResultArr addObject: [self getOSSObjectKeyWithtype:@"png" index:i]];
    }
    _medialist = [_upLoadResultArr componentsJoinedByString:@","];
}

#pragma mark -UITextView收回键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

#pragma mark -UITextFieldDelegate代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
 userid:用户ID  title:梦想名称  describe:梦想描述  slogan:梦想口号
 minamount:最少达成金额 endtime:梦想截止日期 mediatype:媒体类型1图2视频
 dreamtype:梦想类型ID  medialist:视频图片列表 英文逗号分隔
 lablelist:梦想标签列表 英文逗号分隔
 */
#pragma mark - 发布梦想数据请求（520）
- (void)releaseDreamsrequestDataBaseWithTitle:(NSString *)title describe:(NSString *)describe slogan:(NSString *)slogan minamount:(NSString *)minamount endtime:(NSString *)endtime mediatype:(NSString *)mediatype dreamtype:(NSString *)dreamtype medialist:(NSString *)medialist lablelist:(NSString *)lablelist cover:(NSString *)cover
{
    
    NSString *userid = [PersonInfo sharePersonInfo].userId;
    if(userid!=nil)
    {
        NSDictionary *wParamDict = @{@"userid":userid,@"title":title,@"describe":describe,@"slogan":slogan,@"minamount":minamount,@"endtime":endtime,@"mediatype":mediatype,@"dreamtype":dreamtype,@"medialist":medialist,@"lablelist":lablelist,@"cover":cover};
        [PersonInfo sharePersonInfo].wParamDict = wParamDict;
        NSDictionary *wParamDictNew = [PersonInfo sharePersonInfo].wParamDict;
        
        [PersonInfo sharePersonInfo].homePagePic = _homePagePic;
        UIImage *homePagePic = [PersonInfo sharePersonInfo].homePagePic;
        
        [PersonInfo sharePersonInfo].homePagePicObjectKey = _coverStr;
        NSString *homePagePicObjectKey = [PersonInfo sharePersonInfo].homePagePicObjectKey;
        
        BOOL isYES;
        if([self.resourceType isEqualToString:@"photo"])
        {
            //照片
            [PersonInfo sharePersonInfo].isVideo = NO;
            [PersonInfo sharePersonInfo].upLoadResultArr = _upLoadResultArr;
            NSArray *upLoadResultArr = [PersonInfo sharePersonInfo].upLoadResultArr;
            [PersonInfo sharePersonInfo].uoLoadImageArray = _newImageArray;
            NSArray *newImageArray = [PersonInfo sharePersonInfo].uoLoadImageArray;
            if(wParamDictNew!=nil&&homePagePic!=nil&&homePagePicObjectKey!=nil&&upLoadResultArr!=nil&&newImageArray!=nil)
            {
                isYES = YES;
            }
            else
            {
                isYES = NO;
            }
        }
        else
        {
            //视频
            [PersonInfo sharePersonInfo].videoFileURL = self.videoFileURL;
            NSURL *videoFileURL = [PersonInfo sharePersonInfo].videoFileURL;
            [PersonInfo sharePersonInfo].isVideo = YES;
            [PersonInfo sharePersonInfo].medialistObjectKey = _medialist;
            NSString *medialistObjectKey = [PersonInfo sharePersonInfo].medialistObjectKey;
            if(wParamDictNew!=nil&&homePagePic!=nil&&homePagePicObjectKey!=nil&&videoFileURL!=nil&&medialistObjectKey!=nil)
            {
                isYES = YES;
            }
            else
            {
                isYES = NO;
            }
        }
        
        if(isYES)
        {
            //收回
//            dispatch_async(dispatch_get_main_queue(), ^{
            
                [self dismissViewControllerAnimated:NO completion:nil];
//            });
            
            [PersonInfo sharePersonInfo].photoCount = 0;
            //创建通知
            //判断是否个人中心发布梦想
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"MyinfoView"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ISMYINFORELEASE" object:nil];
            }
            else
            {
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UPLOAD_DATA_DREAM" object:nil];
            }
        }
    }
    else
    {
        NSLog(@"用户未登录");
    }
}

#pragma mark - 隐藏系统栏
- (BOOL)prefersStatusBarHidden
{
    return NO; // 返回NO表示要显示，返回YES将hiden
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
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


/// ///  bfbbgbgfgtbbgbgf

@end
