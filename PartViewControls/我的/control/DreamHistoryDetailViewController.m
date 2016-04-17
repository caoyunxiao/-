//
//  DreamHistoryDetailViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "DreamHistoryDetailViewController.h"
#import "DreamCell.h"

#import "MJPhotoBrowser.h"                     //Mj图片浏览器
#import "MJPhoto.h"                            //图片浏览器

#import "SCNavigationController.h"
#import "DreamPicVidModel.h"
#import "VedioDetailViewController.h"          //视屏播放
@interface DreamHistoryDetailViewController ()<UITableViewDataSource,UITableViewDelegate,DreamCellDelegate,UIActionSheetDelegate,SCNavigationControllerDelegate>

@end

@implementation DreamHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    [self requestDataBase];
    
}
#pragma mark - 请求数据
- (void)requestDataBase
{
    _homeModel = [[HomeModel alloc] init];
    if(self.dreamID != nil)
    {
        //NSDictionary *wParamDict = @{@"dreamID":_dreamID};
        
        NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_dreamID,@"dreamID", nil];
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"203" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            NSArray *resultASrr = (NSArray *)resultDict;
            NSDictionary *dict = [resultASrr firstObject];
            if([errorCode isEqualToString:@"0"])
            {
                NSLog(@"梦想数据%@",dict);
                
                [_homeModel setValuesForKeysWithDictionary:dict];
                
                [self.tbView reloadData];
                
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

- (void)configUI
{
    self.title = @"梦想秀历史详情";
    [self setBackButtonWithisPush];
    
    _tbView.delegate = self;
    _tbView.dataSource =self;
    _tbView.backgroundColor = [UIColor blackColor];
   // _homeModel = [[HomeModel alloc] init];
    //添加梦想轨迹点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddDreamForMyOldDream:) name:@"AddDreamForMyOldDream" object:nil];
   
}

#pragma mark - 创建返回按钮
- (void)setBackButtonWithisPush
{
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"TCBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [backBtn addTarget:self action:@selector(backBtnPushNew) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark -返回按钮回调
- (void)backBtnPushNew
{
    [PersonInfo sharePersonInfo].photoCount = 0;
    if (_isDetailGoto) {
        
      [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -添加梦想轨迹数据
- (void)AddDreamForMyOldDream:(NSNotification *)dreameID
{
    NSLog(@"选完照片");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showLoadingViewZFJ];
    [self performSelector:@selector(RefreshDatas) withObject:self afterDelay:1.0];
  
}

- (void)RefreshDatas
{
    __weak typeof(self)wself = self;
    [[CosFundForVideoCYX manager] Releasedreamtrajectory:_dreamID Andmediatype:1 Andbatch:4 AndPhotoArray:[PersonInfo sharePersonInfo].uoLoadImageArray AndVideo:nil Completed:^(NSString *errorCode, NSString *resultDict) {
        
        [wself removeLoadingViewZFJ];
        
        if ([errorCode isEqualToString:@"0"]) {
            
            
            [wself SHOWPrompttext:@"感谢照片上传成功"];
            [wself requestDataBase];
            
            
        }
        else
        {
            [wself SHOWPrompttext:@"感谢照片上传失败,稍后再试！"];
            
        }
        
    }];
}


#pragma mark - UITabelView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"DreamCellId";
    
    DreamCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DreamCell" owner:nil options:nil] lastObject];
        
    }
    
     cell.delegate = self;
    [cell configModle:_homeModel];
    
    return cell;
}
#pragma mark - DreamCell的代理方法
- (void)DreamCellAddDreamButtonClick:(UIButton *)btn
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"添加感谢照片",@"添加感谢视频", nil];
    actionSheet.tag = 210;
    [actionSheet showInView:self.view];
}
#pragma mark - actionSheet代理函数
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //后面需要判断是那个地方在调用添加梦想轨迹
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isMyOldDream"];
    if(actionSheet.tag == 210)
    {
       // NSInteger batch = [[[NSUserDefaults standardUserDefaults]objectForKey:@"batch"] integerValue]+1;
        
//        NSDictionary *ProcessDreams = @{@"dreamid":_dreamID,@"mediatype":buttonIndex == 0?@(1):@(2),@"batch":@"4"};
         NSDictionary *ProcessDreams = [NSDictionary dictionaryWithObjectsAndKeys:_dreamID,@"dreamid",buttonIndex == 0?@(1):@(2),@"mediatype",_dreamID,@"dreamid",@"4",@"batch", nil];
        
        [PersonInfo sharePersonInfo].isProcessDreams = YES;
        if(buttonIndex==0)
        {
            [PersonInfo sharePersonInfo].isVideo = NO;
            //添加照片轨迹
            SCNavigationController *nav = [[SCNavigationController alloc] init];
            nav.scNaigationDelegate = self;
            nav.ISME = YES;
            nav.Trajectorydict = ProcessDreams;
            [nav showCameraWithParentController:self];
            
        }
        else if (buttonIndex == 1)
        {
            [PersonInfo sharePersonInfo].isVideo = YES;
            //添加视频轨迹
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
            
        }
        
    }
}

#pragma amrk -录制视频回调
- (void)qupaiSDK:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    if (videoPath == nil) {
        
        return;
    }
     [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"2Qupai SDK compelete %@",videoPath);
    [self dismissViewControllerAnimated:YES completion:nil];
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
    }
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
   
    __weak typeof(self)wself = self;
    [[CosFundForVideoCYX manager] Releasedreamtrajectory:_dreamID Andmediatype:2 Andbatch:4 AndPhotoArray:nil AndVideo:videoPath Completed:^(NSString *errorCode, NSString *resultDict) {
        
        if ([errorCode isEqualToString:@"0"]) {
            
            [wself SHOWPrompttext:@"感谢视频上传成功"];
            
            [wself requestDataBase];
            
        }
        
    }];
}



- (void)DreamCellDreamtrajectoryClick:(UITapGestureRecognizer *)Tap array:(NSArray *)array
{
    NSInteger index = Tap.view.tag-100;
    NSMutableArray *VideoArr = [NSMutableArray array];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    
  
    for (int j=0; j<[array[index] count]; j++) {
            
//        DreamPicVidModel *model = [[DreamPicVidModel alloc] init];
        DreamPicVidModel *model = array[index][j];
            
        if ([model.Type.description isEqualToString:@"2"] ) {
                
                [VideoArr addObject:model.Url];
            
        }
            
        else{
                //[imageArr addObject:model.Url];
                MJPhoto *photo = [[MJPhoto alloc] init];
                  photo.url = [NSURL URLWithString:[self getImageUrlWithKey:model.Url]];
                 [imageArr addObject: photo];
            }
        }
  
    if (VideoArr.count>0) {
        
        NSString *fileUrl = [self getVideoUrlWithKey:VideoArr[0]];
        VedioDetailViewController *vedioVC = [[VedioDetailViewController alloc] init];
        
        NSLog(@"播放%@",fileUrl);
        
        vedioVC.FileUrl = fileUrl;
        [self.navigationController pushViewController:vedioVC animated:YES];
      
    }
    
    if (imageArr.count>0) {
        
        MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
        brower.photos = imageArr;
        [brower show];

        /*如果他不认同和别人挺好不那你不让你不让你不管不管别人改天吧认同和别人挺好不认同和别人挺好不认同*/
    }

}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
