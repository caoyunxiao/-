//
//  PersonalHomepageController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "PersonalHomepageController.h"
#import "DreamHiostoryController.h"

#import "PersonModel.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface PersonalHomepageController ()

@property (nonatomic ,strong) PersonModel *personModle;
@end

@implementation PersonalHomepageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人主页";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self configUI];
   /*刚把而非他刚把二表哥啊人个人各*/
}


- (void)requestDataBase
{
    __weak typeof (self)wself= self;
    
    NSString *usId ;
    if (_isCao == YES) {
        
        usId = self.userid;
        
    }
    else
    {
        usId = _model.userID.description;
    }
    NSDictionary *wParamDict = @{@"userid":usId};
    
    [self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"511" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        [wself removeLoadingViewZFJ];
      
        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];
             NSLog(@"获取数据requestDataBase%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            wself.personModle = [[PersonModel alloc] init];
            
            [wself.personModle setValuesForKeysWithDictionary:array[0]];
            [self configUI];
            
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            //[wself showLoadingFailureViewZFJ:@"数据加载失败，请刷新试一下..."];
        }
    }];
   /*faefgvergergergerrgtfbebetbebet二个人感情而个人个人感情而过betbebebebetbebetbgerger*/
}
#pragma mark - 配置UI
- (void)configUI
{
    //设置滚动视图滚动范围
    self.bgScroller.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    
    //设置头像的圆角
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:_personModle.headImg]] placeholderImage:PlaceholderImage];
    
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headImage.clipsToBounds = YES;
    self.headImage.userInteractionEnabled = YES;
    self.headImage.layer.borderWidth = 0.3;
    [self.headImage.layer setCornerRadius:self.headImage.height/2];
    [self.headImage.layer setMasksToBounds:YES];
     self.headImage.layer.borderColor = TCColordefault.CGColor;

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HeadImagTap:)];
    
    [self.headImage addGestureRecognizer:tap];
    
   // self.phoneLabel.text = [_personM]
    self.userNameLabel.text = [_personModle.nickname description];
    self.regionLabel.text = [_personModle.describe description];
    self.ageLabel.text = [_personModle.age description];
    
    self.phoneLabel.text = [_personModle.userName description];
    

    
    [self.backBtn setMyCorner];
    
    
}
#pragma mark - gerg
- (void)HeadImagTap:(UITapGestureRecognizer *)tap
{
    NSMutableArray *arr = [NSMutableArray array];
    
    
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString:[self getImageUrlWithKey:_personModle.headImg]];
    [arr addObject: photo];
    
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = arr;
    
    [brower show];
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self requestDataBase];
}
#pragma mark - 点击进入梦想详情
- (IBAction)tapDreamHistory:(UITapGestureRecognizer *)sender {
    
    
    DreamHiostoryController *dreamVc = [[DreamHiostoryController alloc] init];
    
    if (_isCao == YES) {
        
        dreamVc.userId = self.userid;
        
        dreamVc.isCao = YES;
    }
    else
    {
        dreamVc.userId = _model.userID.description;
    }

  
        [self.navigationController pushViewController:dreamVc animated:YES];
  
    
}
#pragma mark - 返回首页
- (IBAction)backClick:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
