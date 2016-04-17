//
//  SettingViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SettingViewController.h"
#import "MyAddressViewController.h"         //地址设置视图控制器
#import "NewPasswordViewController.h"       //重置密码视图控制器
#import "AboutViewController.h"             //关于我试图控制器
#import "ContactSeverViewController.h"      //联系客服试图控制器

#import "TwoShoppingCartController.h"       //邱亚青购物车测试

#import "SettingGroup.h"      //存放组数据的模型
#import "SettingArrowItem.h"       //存放单个数据模型
#import "SettingLabelItem.h"
#import "MyButton.h"
#import "SDImageCache.h"                  //清理缓存类
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //继承基类的方法，设置导航栏左边的返回按钮
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    //[self creatExitLogin];
    //初始化数据源
    __weak typeof(self) wself = self;
    SettingArrowItem *item1 = [SettingArrowItem itemWithIcon:nil title:@"地址设置"];
    item1.operation = ^{
        
        if ([PersonInfo sharePersonInfo].isLogIn != YES) {
            Alert(@"您还未登陆，请先登陆");
            return ;
        }
         MyAddressViewController *myAddress =  [[MyAddressViewController alloc] init];
        
        [wself.navigationController pushViewController:myAddress animated:YES];
    };

    
    SettingArrowItem *item2 = [SettingArrowItem itemWithIcon:nil title:@"重置密码" ];
    item2.operation =  ^{

        
        if ([PersonInfo sharePersonInfo].isLogIn != YES) {
            Alert(@"您还未登陆，请先登陆");
            return ;
        }
        NewPasswordViewController *newVc =  [[NewPasswordViewController alloc] init];
        
        [wself.navigationController pushViewController:newVc animated:YES];
    };


    
    SettingGroup *group1 = [[SettingGroup alloc] init];
    group1.items = @[item1,item2];
    [self.cellData addObject:group1];
    
//    
//    SettingArrowItem *item4 = [SettingArrowItem itemWithIcon:nil title:@"去评分" vcClass:nil];
//    item4.operation = ^{
//        
//        //跳到appstore 对应的应用的界面
//        /*1.评分
//         》使用UIApplication打开URL 如 "itms-apps://itunes.apple.com/cn/app/%@?mt=8"
//         》注意把id替换成appid //eg.725296055
//         //appid 与bundleId是不同，每一个应用上传到appstore之后，就会有一个ID,这个ID是纯数字
//         》什么是appID,每个应用上架后就有个application ID
//         */
//        
//        //itms-apps://itunes.apple.com/cn/app/725296055?mt=8
//        //itms-apps://itunes.apple.com/cn/app/725296055?mt=8
//        NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/%@?mt=8",@"1052432271"];
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//    };
    
    
    NSString *text = [NSString stringWithFormat:@"缓存:%.1lfM",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0];
    SettingArrowItem *item5 =[SettingArrowItem itemWithIcon:nil title:@"清理缓存" subTitle:text vcClass:nil];
    
    __weak typeof(item5) wItem5 = item5;

    item5.operation = ^{
        
      
        [[SDImageCache sharedImageCache] clearDisk];
        
        [[SDImageCache sharedImageCache] clearMemory];//可

        
            [wself SHOWPrompttext:@"清理缓存成功"];
      
        
        
        [wself.tbView reloadData];
       wItem5.subTitle = [NSString stringWithFormat:@"缓存:%.1lfM",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0];
        
    };

    
    SettingArrowItem *item6 = [SettingArrowItem itemWithIcon:nil title:@"关于我们"];
    item6.vcClass = [AboutViewController class];
    
    SettingArrowItem *item7 = [SettingArrowItem itemWithIcon:nil title:@"联系客服" ];
    item7.vcClass = [ContactSeverViewController class];
    
    
     
    
    
    SettingGroup *group2 = [[SettingGroup alloc] init];
    
    //group2.items = @[item4,item5,item6,item7];
    
    group2.items = @[item5,item6,item7];
    [self.cellData addObject:group2];
    
    SettingLabelItem *item9 = [[SettingLabelItem alloc] init];
    item9.text = @"退出登录";
    
    
    item9.operation = ^{
        
        
        /*我认识的高vfrbvebebedbedbebetfbebtebeb*/
        [PersonInfo sharePersonInfo].isLogIn = NO;
        [[PersonInfo sharePersonInfo] resetPersonInfo];
        
        
        [self.navigationController popViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitLogin" object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedIndex" object:@(0)];
        SHARED_APPDELEGATE.Mytabbar.selectedIndex = 0;
        for (UIView *view in SHARED_APPDELEGATE.Mytabbar.imageview.subviews) {
            
            if ([view isKindOfClass:[MyButton class]]) {
                
                MyButton *button = (MyButton *)view;
                button.selected = NO;
            }
        }
        MyButton *button = [SHARED_APPDELEGATE.Mytabbar.imageview.subviews firstObject];
        button.selected = YES;
    
        
        Alert(@"退出登陆成功");
        
        
    };
    
    
    SettingGroup *group3 = [[SettingGroup alloc] init];
    group3.items = @[item9];
    
    [self.cellData addObject:group3];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

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

@end
