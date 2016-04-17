//
//  PersonalFileViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/4.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "PersonalFileViewController.h"
#import "HENLENSONG.h"

#import "UIImageView+WebCache.h"
#import "SureSuessController.h"

@interface PersonalFileViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

{
    UITextField *_textField;
    
    NSString *_myGender;
    
    
}

/**
 *  用户头像
 */


@property (nonatomic, strong) UIActionSheet *genderActionSheet;

/**
 *  头像的ObjectKey
 */
@property (nonatomic, copy) NSString *headerImgKey;

/**
 *  头像提示框
 */
@property (nonatomic, strong) UIActionSheet *headerSheet;

/**
 *  头像
 */
@property (nonatomic, strong) NSData *headImg;
@end

@implementation PersonalFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (_isBackhome) {
        
        [self setBackButtonWithisPush];
    }
    else
    {
        if(self.isPress==YES)
        {
            [self setBackButtonWithisPush:NO AndViewcontroll:self];
        }
        else
        {
            [self setBackButtonWithisPush:YES AndViewcontroll:self];
        }
    }

    [self initInfor];
    [self configUI];
    
    
/*不vetbetberbeberber被台北推背图八个人根本而*/
}

#pragma mark - 创建返回按钮
- (void)setBackButtonWithisPush
{
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"TCBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -返回主界面
- (void)backBtn
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedIndex" object:@(5)];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
    

     
}


#pragma mark - 初始化用户信息
- (void)initInfor
{
    self.title = @"个人档案";
    //NSLog(@"用户所有信息%@",[PersonInfo sharePersonInfo]);
    self.headerImgKey = [PersonInfo sharePersonInfo].headImg;
    
    
   
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:self.headerImgKey]] placeholderImage:PlaceholderImage];


    
    if (![[PersonInfo sharePersonInfo].nickname isKindOfClass:[NSNull class]]) {
        
        self.nikeNameTextField.text = [PersonInfo sharePersonInfo].nickname;
        
    }
    if (![[PersonInfo sharePersonInfo].describe isKindOfClass:[NSNull class]]) {
        
        self.introduceTextField.text = [PersonInfo sharePersonInfo].describe;
        
    }
    if (![[PersonInfo sharePersonInfo].gender isKindOfClass:[NSNull class]]) {
        
        if ([[PersonInfo sharePersonInfo].gender isEqualToString:@"0"]) {
            _myGender = @"男";
        }else if ([[PersonInfo sharePersonInfo].gender isEqualToString:@"1"])
        {
            _myGender = @"女";
        }
        else
        {
            _myGender = @"保密";
        }
        
        self.genderName.text = _myGender;
        
    }

    if (![[PersonInfo sharePersonInfo].age isKindOfClass:[NSNull class]]) {
        
       self.ageTextField.text = [PersonInfo sharePersonInfo].age;
        
    }

    if (![[PersonInfo sharePersonInfo].email isKindOfClass:[NSNull class]]) {
        
       self.EmailTextField.text = [PersonInfo sharePersonInfo].email;
        
    }

    
    
    
}

#pragma mark - configUI
- (void)configUI
{

    //设置背景滚动视图
    self.bgScrollerView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*1.5);
    self.bgScrollerView.canCancelContentTouches = NO;
    self.bgScrollerView.delaysContentTouches = NO;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    
    [self.bgScrollerView addGestureRecognizer:tapGestureRecognizer];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //头像的圆角
    
    self.headerImageView.layer.borderWidth = 0.3;
    [self.headerImageView.layer setCornerRadius:self.headerImageView.height/2];
    
    self.headerImageView.layer.shouldRasterize = YES;
    self.headerImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.headerImageView.layer setMasksToBounds:YES];
    self.headerImageView.layer.borderColor = TCColordefault.CGColor;
    
    
    [self setuUpViewBoard:self.nikeNameView];
    [self setuUpViewBoard:self.introduceView];
    [self setuUpViewBoard:self.genderView];
    [self setuUpViewBoard:self.ageView];
    [self setuUpViewBoard:self.EmailView];
    //打开label的交互
    self.genderName.userInteractionEnabled = YES;
    
    self.nikeNameTextField.delegate = self;
    self.introduceTextField.delegate = self;
    self.ageTextField.delegate = self;
    self.EmailTextField.delegate = self;
    
    [self.sureSaveBtn setMyCorner];
    
      
}
#pragma mark - 退键盘的方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_textField resignFirstResponder];
    
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
   
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSLog(@"%@",userInfo);
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    
    if ([_textField superview].y >=((ScreenHeight-64) - keyboardHeight)) {
        
        
        _bgScrollerView.contentOffset = CGPointMake(0,  ([_textField superview].y -((ScreenHeight-64) - keyboardHeight))+64);
    }

}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.bgScrollerView.contentOffset = CGPointMake(0, 0);
}
//抽方法 设置View的边框
- (void)setuUpViewBoard:(UIView *)view
{
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1;
}

#pragma mark - 保存用户信息
- (IBAction)sureSaveClick:(UIButton *)sender
{
    if (self.headerImgKey.length<=0) {
        Alert(@"请点击头像上传你的头像");
        return;
    }
    if (self.nikeNameTextField.text.length<=0) {
        Alert(@"昵称不能为空");
        return;
    }
    if (self.nikeNameTextField.text.length>=8) {
        Alert(@"名字不能超过8个字符");
        return;
    }
    if (self.introduceTextField.text.length >15) {
        Alert(@"自我介绍不能超过15个字");
        return;
    }
    if (self.genderName.text.length<=0) {
        Alert(@"性别不能为空");
    }
    if (self.introduceTextField.text.length <=0) {
        Alert(@"自我介绍不能为空");
        return;
    }
    if (self.ageTextField.text.length>=3||[self.ageTextField.text isEqualToString:@"0"]) {
        Alert(@"输入的年龄不正确");
        return;
    }
    
    if ([HENLENSONG isValidateEmail:self.EmailTextField.text]==NO ) {
        Alert(@"输入的邮箱格式不正确");
        return;
    }
   
     NSString *postGender;
    NSLog(@"%@",_myGender);
    if ([_genderName.text isEqualToString:@"男"]) {
        postGender = @"0";
    }
    else if ([_genderName.text isEqualToString:@"女"])
    {
        postGender = @"1";
    }
    else
    {
        postGender = @"2";
    }
   
   
    NSString *headerImageKey;
    if (self.headerImgKey) {
        
        headerImageKey = self.headerImgKey;
    }else{
        
        headerImageKey = [PersonInfo sharePersonInfo].headImg;
    }
    
    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userName,@"nickname":self.nikeNameTextField.text,@"describe":self.introduceTextField.text,@"gender":postGender,@"age":self.ageTextField.text,@"email":self.EmailTextField.text,@"headimg":self.headerImgKey};
    
    NSLog(@"提交到服务器的ossKey%@",headerImageKey);
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"106" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if([errorCode isEqualToString:@"0"])
        {
#warning 补全用户信息
            NSLog(@"保存成功");
            [PersonInfo sharePersonInfo].myHeadImageData = _headImg;
            [PersonInfo sharePersonInfo].headImg = headerImageKey;
            [PersonInfo sharePersonInfo].nickname = self.nikeNameTextField.text;
            
            [PersonInfo sharePersonInfo].describe = self.introduceTextField.text;
            
            [PersonInfo sharePersonInfo].gender = postGender;
            [PersonInfo sharePersonInfo].age = self.ageTextField.text;
            [PersonInfo sharePersonInfo].email = self.EmailTextField.text;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"InfoSuccess" object:nil];
            
            [PersonInfo sharePersonInfo].isLogIn = YES;
            
            SureSuessController *sureVc = [[SureSuessController alloc] init];
            
            [self.navigationController pushViewController:sureVc animated:YES];
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
            
            return;
        }
    }];

   
}
- (IBAction)nikeNameTextField:(UITextField *)sender {
    
        
}

#pragma mark - 点击性别的Label
- (IBAction)tapGenderLabel:(UITapGestureRecognizer *)sender {
    
    self.genderActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",@"保密", nil];
    
    self.genderActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [self.genderActionSheet showInView:self.view];
    
    
}
#pragma mark - 点击头像。
- (IBAction)HeaderIamgeTap:(UITapGestureRecognizer *)sender {
    self.headerSheet = [[UIActionSheet alloc]
                        initWithTitle:nil
                        delegate:self
                        cancelButtonTitle:@"取消"
                        destructiveButtonTitle:nil
                        otherButtonTitles:@"从手机相册选择", @"拍照",nil];
    self.headerSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [self.headerSheet showInView:self.view];
}
#pragma mark - UIActionSheet的协议方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.genderActionSheet) {
        if (buttonIndex == 0) {
            _genderName.text = @"男";
            _myGender =  @"0";
        }else if (buttonIndex == 1) {
            _genderName.text = @"女";
            _myGender = @"1";
        }
        else if (buttonIndex == 2){
            
            _genderName.text =  @"保密";
            _myGender = @"2";
            
        }
        
        return;
    }
    
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self LocalPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
        default:
            break;
    }
    
}
#pragma mark - 从相册选择
-(void)LocalPhoto{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    

}
#pragma mark - 照相
-(void)takePhoto{
    //资源类型为照相机

    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        
       
    }else {
        NSLog(@"该设备无摄像头");
    }
}
#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
   
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        //图片显示在界面上
    
        //把图片转成NSData类型的数据来保存文件
        NSData *data ;
        //判断图片是不是png格式的文件
        UIImage *newImage = [self imageWithImage:image scaledToSize:CGSizeMake(90, 90)];
         NSLog(@"图片的高度%f",newImage.size.height);
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            
           NSData *data2 = UIImagePNGRepresentation(newImage);
           UIImage *image2 = [UIImage imageWithData:data2];
            
            data = UIImageJPEGRepresentation(image2, 1);
            
            
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(newImage, 1);
        }
        
        _headImg = data;
        __weak typeof(self) wself = self;
        
        [OSSLog enableLog];
        
        self.headerImgKey = [BaseViewController getOSSObjectKeyWithtype:@"jpg"];
       // NSLog(@"上传的头像的oosKey%@",self.headerImgKey);
         [MBProgressHUD showMessage:@"头像上传中"];
        
        [OSSHelper uploadImageObjectWithKey:self.headerImgKey  data:data success:^id(OSSTask *task) {
            [wself performSelectorOnMainThread:@selector(refreshUI:) withObject:data waitUntilDone:YES];
            
            return nil;
        }];
        /*tgbeq4tg4ergrgrg*/
        /*hynjtyntgtrggjteyjntyjntyjntyjntyjntyjntyjn*/

    }
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)refreshUI:(NSData *)data
{
    self.headerImageView.image = [UIImage imageWithData:data];
    
    Alert(@"头像上传成功");
    [MBProgressHUD hideHUD];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - 对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);

    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
#pragma mark - UITextFielField协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];

    return YES;
}
//当用户开始编辑时执行此协议方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textField = textField;
}

#pragma mark - 移除通知
- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
