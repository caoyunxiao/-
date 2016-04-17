//
//  ReleaseRreamsViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ReleaseRreamsViewController.h"
#import "ReleaseRreamsCell.h"
#import "HySideScrollingImagePicker.h"
#import "SGImagePickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ReleaseRreamsViewController ()

@end

@implementation ReleaseRreamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self configUI];
}

#pragma mark - 设置配置文件
- (void)configUI
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVideoFileURL:) name:@"VIDEO_FILE_URL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haveChoseOneWay:) name:@"HAVE_CHOSE_ONE_WAY" object:nil];
    
    self.title = @"发布梦想";
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    self.RDTableView.delegate = self;
    self.RDTableView.dataSource = self;
    self.RDTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _imageWidth = (ScreenWidth-40)/4;
    
    _imageArray = [[NSMutableArray alloc]init];
    
    _oneOrTwo = NO;
}

#pragma mark - 通知事件
-(void)getVideoFileURL:(NSNotification *)aNoti
{
    // 通知传值
    NSDictionary *dic = [aNoti userInfo];
    _videoFileURL = [dic valueForKey:@"videoFileURL"];
}
-(void)haveChoseOneWay:(NSNotification *)aNoti
{
    _oneOrTwo = YES;
}

#pragma mark - 发布梦想
- (void)rightButtonClick
{
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
}

#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _dataArray.count;
    return 1;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger q1 = (_imageArray.count+1)/4;
    NSInteger cellheight= 4*(_imageWidth+8)+292;
    return cellheight;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ReleaseRreamsCell";
    ReleaseRreamsCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReleaseRreamsCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        [cell.RDreamsAddImage addTarget:self action:@selector(RDreamsAddImageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    if(_imageArray.count>0)
    {
        [cell showUIViewWithImageArr:_imageArray];
    }
    return cell;
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - cell的点击添加图片
- (void)RDreamsAddImageClick
{
    [self showWayOfFaBuMyDrams];
}

#pragma mark - 发布梦想的方式选择
- (void)showWayOfFaBuMyDrams
{
    HySideScrollingImagePicker *hy = [[HySideScrollingImagePicker alloc] initWithCancelStr:@"取消" otherButtonTitles:@[@"手机相册",@"拍照"]];
    hy.isMultipleSelection = false;
    
    hy.SeletedImages = ^(NSArray *GetImages, NSInteger Buttonindex)
    {
        
        for (UIImage *image in GetImages) {
            if(_imageArray)
            {
                if(![_imageArray containsObject:image])
                {
                    [_imageArray addObject:image];
                }
            }
        }
        [self ToDealWithTheWayOfMyDrams:Buttonindex];
        
    };
    [self.view insertSubview:hy atIndex:[[self.view subviews] count]];
    _hyFrame = hy.frame;
    _hyFrame.origin.y = self.view.frame.size.height - hy.frame.size.height;
    hy.frame = _hyFrame;
}
#pragma mark - 处理梦想的方式
- (void)ToDealWithTheWayOfMyDrams:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //取消
    }
    else if(buttonIndex==1)
    {
        if(_oneOrTwo)
        {
            if(_imageArray.count>0)
            {
                //已经选好的照片
                [self.RDTableView reloadData];
            }
            _oneOrTwo = NO;
        }
        else
        {
            [self SGImagePickerController];
        }
    }
    else if(buttonIndex==2)
    {
        //拍照
        //设置资源类型
        UIImagePickerController *pc = [[UIImagePickerController alloc]init];
        pc.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [pc setSourceType:UIImagePickerControllerSourceTypeCamera];
            pc.allowsEditing = YES;
            [self presentViewController:pc animated:YES completion:nil];
        }
        else
        {
            NSLog(@"相机无法使用");
        }
    }
    else if(buttonIndex==3)
    {
        
    }
}

#pragma mark - 从手机相册中选择
- (void)SGImagePickerController
{
    //从手机相册中选择
    SGImagePickerController *picker = [[SGImagePickerController alloc] init];
    
    //返回选择的缩略图
    [picker setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
        
        
    }];
    //返回选中的原图
    [picker setDidFinishSelectImages:^(NSArray *images) {
        for (UIImage *image in images)
        {
            if(_imageArray)
            {
                if(![_imageArray containsObject:image])
                {
                    [_imageArray addObject:image];
                }
            }
        }
        if(_imageArray.count>0)
        {
            [self.RDTableView reloadData];
        }
    }];
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate相关
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //判断资源类型的
    NSString *str = [info objectForKey:UIImagePickerControllerMediaType];
    if ([str isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        [self dismissViewControllerAnimated:YES completion:nil];
        [_imageArray addObject:image];
        if(_imageArray.count>0)
        {
            [self.RDTableView reloadData];
        }
    }
    else
    {
        NSLog(@"图片设置失败");
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"VIDEO_FILE_URL" object:nil];
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
