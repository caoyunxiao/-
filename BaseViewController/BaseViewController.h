//
//  BaseViewController.h
//  CosFund
//
//  Created by vivian on 15/9/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIAlertViewDelegate>{
    
    UIButton *_carBtn;
    NSInteger _page;	//页数
    NSInteger _size;	//数据量
    
    UILabel *tiShiLabel;
}
/**
 *  加载失败
 */
@property (nonatomic, strong) UIView *loadingFailureView;
- (void)showLoadingViewZFJ;     //显示等待视图
- (void)removeLoadingViewZFJ;   //移除等待视图

- (void)showLoadingFailureViewZFJ:(NSString *)textLabel;//显示加载失败

- (void)removeLoadingFailureViewZFJ;//移除加载失败

//创建返回按钮
- (void)setBackButtonWithisPush:(BOOL)isPush AndViewcontroll:(UIViewController *)Viewself;

//设置购物车
- (void)setShopRightButton;

//隐藏多余的cell分界面
- (void)setExtraCellLineHidden:(UITableView *)tableView;

//弹出 梦想秀
//- (void)showDreamMenu;

//渐隐提示框
- (void)SHOWPrompttext:(NSString *)Text;

//判断相机权限是否开启
- (BOOL)Determinethecamerapermissions;
//判断相册权限是否开启
- (BOOL)Judgealbumpermissions;



//父类 购物车方法
- (void)carBtnClick;

//密码加密算法
- (NSString *)collegePasswordEncryptionAlgorithm:(NSString *)passWord;

//获取时间戳
+ (NSString *)getTheTimestamp;

//把时间戳格式化输出
+ (NSString *)getTimerStrFromTimestamp:(NSString *)timeString;

//获取一个时间距离现在的时间
+ (NSString *)intervalSinceNow: (NSString *) theDate;
/**
 *  将服务器时间转化成字符串
 *
 *  @param SeverTime <#SeverTime description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTimerStrFromSever:(NSString *)SeverTime;
//通过字典获取wParam
+ (NSString *)getwParamFromDict:(NSDictionary *)dict;

//通过字典获取bodyString
+ (NSString *)getBodyStringFromDict:(NSDictionary *)dict;




- (void)shareWith:(NSString *)text image:(UIImage *)image;
/**
 *  分享的方法
 *
 *  @param text     分享的文字
 *  @param image    分享的图片（可填nil）
 *  @param imageURL 分享的图片url（传一个url字符串即可）没有可填空
 *  @param videoURL 分享的视频url (传一个视频url字符串) 没有可填空
 */
- (void)shareWithTitle:(NSString *)title describe:(NSString *)describe image:(UIImage *)image imageURL:(NSString *)imageURL video:(NSString *)videoURL  returnURL:(NSString *)returnURL;

//提示登录的信息
- (void)showLogInViewController;

//提示登录的信息
+ (void)showLogInViewControllerTwo;

- (void)backBtnPush;


//获取OSS的ObjectKey
+ (NSString *)getOSSObjectKey;
+ (NSString *)getOSSObjectKey:(NSInteger)index;
/**
 *  获取ossKEY
 *
 *  @param type 文件名后缀例如：jpg, mp4;
 *
 *  @return ossKEY
 */
- (NSString *)getOSSObjectKeyWithtype:(NSString *)type;
/**
 *  获取多个ossKEY
 *
 *  @param type 文件名后缀例如：jpg, mp4;
 *  @param index 下标，用来同时获取多个key
 *
 *  @return ossKEY
 */
- (NSString *)getOSSObjectKeyWithtype:(NSString *)type index:(NSInteger)index;

/**
 *  获取图片文件的全路径
 *
 *  @param oSSObjectKey oSSObjectKey
 *
 *  @return 完整的图片URL
 */
- (NSString *)getImageUrlWithKey:(NSString *)oSSObjectKey;
/**
 *  获取视频文件呢的全路径
 *
 *  @param oSSObjectKey oSSObjectKey
 *
 *  @return 完整视屏的URL
 */
- (NSString *)getVideoUrlWithKey:(NSString *)oSSObjectKey;

+ (NSString *)getOSSObjectKeyWithtype:(NSString *)type;

+ (NSString *)getOSSObjectKeyWithtype:(NSString *)type index:(NSInteger)index;

+ (NSString *)getImageUrlWithKey:(NSString *)oSSObjectKey;

+ (NSString *)getVideoUrlWithKey:(NSString *)oSSObjectKey;









- (void)UPLOAD_DATA_DREA:(NSNotification *)text;
- (void)HOME_PAGE_PIC_DAT:(NSNotification *)text;
- (void)MEDIALIST_UPLOAD_DATA_DOW:(NSNotification *)text;





@end






























