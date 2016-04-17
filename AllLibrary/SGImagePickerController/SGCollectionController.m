//
//  SGCollectionController.m
//  SGImagePickerController
//
//  Created by yyx on 15/10/3.
//  Copyright (c) 2015年 张福杰. All rights reserved.
//

#import "SGCollectionController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SGAssetModel.h"
#import "SGPhotoBrowser.h"
#import "SGImagePickerController.h"
#define MARGIN 10
#define COL 4
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface SGShowCell : UICollectionViewCell
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation SGShowCell

@end

@interface SGCollectionController ()
@property (nonatomic,strong) NSMutableArray *assetModels;
//选中的模型
@property (nonatomic,strong) NSMutableArray *selectedModels;
//选中的图片
@property (nonatomic,strong) NSMutableArray *selectedImages;
@end

@implementation SGCollectionController

static NSString * const reuseIdentifier = @"Cell";
//设置类型
- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MARGIN;
    flowLayout.minimumInteritemSpacing = MARGIN;
    CGFloat cellHeight = (kWidth - (COL + 1) * MARGIN) / COL;
    flowLayout.itemSize = CGSizeMake(cellHeight, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [super initWithCollectionViewLayout:flowLayout];
}
- (NSMutableArray *)assetModels{
    if (_assetModels == nil) {
        _assetModels = [NSMutableArray array];
    }
    return _assetModels;
}
- (NSMutableArray *)selectedImages{
    if (_selectedImages == nil) {
        _selectedImages = [NSMutableArray array];
    }
    return _selectedImages;
}
- (NSMutableArray *)selectedModels{
    if (_selectedModels == nil) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}
- (void)setGroup:(ALAssetsGroup *)group{
    _group = group;
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) return ;
        if (![[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            return;
        }
        SGAssetModel *model = [[SGAssetModel alloc] init];
        model.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
        model.imageURL = asset.defaultRepresentation.url;
        [self.assetModels addObject:model];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[SGShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-40);
    [self setBackButton];
    [self setDowmUIView];
}
#pragma mark - 设置底部UI控件
- (void)setDowmUIView
{

    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-40, ScreenWidth, 40)];
    [self.view addSubview:downView];
    downView.backgroundColor = [UIColor colorWithRed:210/255.0 green:20/255.0 blue:104/255.0 alpha:1];
    
    //提示label
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(downView.frame.size.width-45-8-20, (40-20)/2, 20, 20)];
    _numLabel.font = [UIFont systemFontOfSize:12];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.layer.masksToBounds = YES;
    _numLabel.layer.cornerRadius = 10;
    _numLabel.backgroundColor = [UIColor colorWithRed:9/255.0 green:187/255.0 blue:7/255.0 alpha:1];
    _numLabel.hidden = YES;
    [downView addSubview:_numLabel];
    
    //预览
    UIButton *previewBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 0, 45, 40)];
    [previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [downView addSubview:previewBtn];
    [previewBtn addTarget:self action:@selector(previewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //完成
    UIButton *completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(downView.frame.size.width-45-8, 0, 45, 40)];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [downView addSubview:completeBtn];
    [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 预览
- (void)previewBtnClick
{
    if ([self.navigationController isKindOfClass:[SGImagePickerController class]])
    {
        SGImagePickerController *picker = (SGImagePickerController *)self.navigationController;
        if (picker.didFinishSelectThumbnails || picker.didFinishSelectImages)
        {
            for (SGAssetModel *model in self.assetModels)
            {
                if (model.isSelected){
                    if(![self.selectedModels containsObject:model])
                    {
                        [self.selectedModels addObject:model];
                    }
                }
            }
        }
    }
    if (self.selectedModels.count == 0) {
        
        Alert(@"请至少选择一张照片");
        return;
    }
    SGPhotoBrowser *browser = [[SGPhotoBrowser alloc] init];
    browser.assetModels = self.selectedModels;
    browser.currentIndex = 0;
    [browser show];
}

- (NSArray *)getNewImageArray;
{
    if ([self.navigationController isKindOfClass:[SGImagePickerController class]])
    {
        SGImagePickerController *picker = (SGImagePickerController *)self.navigationController;
        if (picker.didFinishSelectThumbnails || picker.didFinishSelectImages)
        {
            for (SGAssetModel *model in self.assetModels)
            {
                if (model.isSelected){
                    if(![self.selectedModels containsObject:model])
                    {
                        [self.selectedModels addObject:model];
                    }
                }
            }
        }
    }
    return self.selectedModels;
}

#pragma mark - 完成
- (void)completeBtnClick
{
    [self finishSelecting];
}

#pragma mark - 创建返回按钮
- (void)setBackButton
{
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"TCBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [backBtn addTarget:self action:@selector(backBtnPush) forControlEvents:UIControlEventTouchUpInside];
    
    //右侧完成按钮
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.frame = CGRectMake(0, 0, 45, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = cancelItem;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 取消
- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 返回上一级
- (void)backBtnPush
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 出口,选择完成图片
- (void)finishSelecting
{
    if ([self.navigationController isKindOfClass:[SGImagePickerController class]])
    {
        SGImagePickerController *picker = (SGImagePickerController *)self.navigationController;
        if (picker.didFinishSelectThumbnails || picker.didFinishSelectImages)
        {
            for (SGAssetModel *model in self.assetModels)
            {
                if (model.isSelected){
                    if(![self.selectedModels containsObject:model])
                    {
                        [self.selectedModels addObject:model];
                    }
                }
            }
            //获取原始图片可能是异步的,因此需要判断最后一个,然后传出
            for (int i = 0; i < self.selectedModels.count; i++)
            {
                SGAssetModel *model = self.selectedModels[i];
                [model originalImage:^(UIImage *image) {
                    [self.selectedImages addObject:image];
                    if ( i == self.selectedModels.count - 1) {//最后一个
                        if (picker.didFinishSelectImages) {
                            picker.didFinishSelectImages(self.selectedImages);
                        }
                    }
                }];
            }
            if (picker.didFinishSelectThumbnails)
            {
                picker.didFinishSelectThumbnails([_selectedModels valueForKeyPath:@"thumbnail"]);
            }
        }
    }
    //移除
    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SGShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    SGAssetModel *model = self.assetModels[indexPath.item];
   SGAssetModel *model = [self.assetModels objectAtQYQIndex:indexPath.item];
    
    if (cell.backgroundView == nil)
    {
        //防止多次创建
        UIImageView *imageView = [[UIImageView alloc] init];
        cell.backgroundView = imageView;
    }
    UIImageView *backView = (UIImageView *)cell.backgroundView;
    backView.image = model.thumbnail;
    if (cell.selectedButton == nil)
    {
        //防止多次创建
        UIButton *selectButton = [[UIButton alloc] init];
        [selectButton setImage:[UIImage imageNamed:@"sg_normal"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"sg_seleted"] forState:UIControlStateSelected];
        CGFloat width = cell.bounds.size.width;
        selectButton.frame = CGRectMake(width - 30, 0, 30, 30);
        [cell.contentView addSubview:selectButton];
        cell.selectedButton = selectButton;
        [selectButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectedButton.tag = indexPath.item;//重新绑定
    cell.selectedButton.selected = model.isSelected;//恢复设定状态
    return cell;
}
- (void)buttonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    //SGAssetModel *model = self.assetModels[sender.tag];
    
    SGAssetModel *model = [self.assetModels objectAtQYQIndex:sender.tag];
    
    //因为冲用的问题,不能根据选中状态来记录
    if (sender.selected == YES)
    {
        //选中了记录
        model.isSelected = YES;
    }
    else
    {
        //否则移除记录
        model.isSelected = NO;
        if([self.selectedModels containsObject:model])
        {
            [self.selectedModels removeObject:model];
        }
    }
    NSInteger count = [self getNewImageArray].count;
    NSInteger photoCount = [PersonInfo sharePersonInfo].photoCount;
    NSInteger mun = count + photoCount;
    if(mun > 6)
    {
        Alert(@"最多只能上传6张照片");
        if([self.selectedModels containsObject:model])
        {
            [self.selectedModels removeObject:model];
        }
        sender.selected = NO;
        model.isSelected = NO;
        return;
    }
    if(count>0)
    {
        _numLabel.hidden = NO;
        _numLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    }
    else
    {
        _numLabel.hidden = YES;
    }
    
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SGPhotoBrowser *browser = [[SGPhotoBrowser alloc] init];
    browser.isShowBigImage = YES;
    browser.assetModels = self.assetModels;
    browser.currentIndex = indexPath.item;
    [browser show];
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.selectedModels removeAllObjects];
    [PersonInfo sharePersonInfo].photoCount = 0;
}



@end
