//
//  SearchViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/13.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultController.h"        //搜索结果页面

@interface SearchViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;   //数据源数组

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackButtonWithisPush:NO AndViewcontroll:self];
    [self uiConfig];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dataArr = [NSMutableArray arrayWithArray:[self unAchive] ];
    [self.SVTableView reloadData];
    
}
- (void)uiConfig
{
    self.title = @"搜索";
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    self.SVTableView.delegate = self;
    self.SVTableView.dataSource = self;
    [self setExtraCellLineHidden:self.SVTableView];
    self.searchText.delegate = self;
    
    

}
#pragma mark - 退键盘的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



#pragma mark - 归档
- (void)achiveWithArray:(NSMutableArray *)array
{
    NSString *localPath = @"Documents/muArrayFindHistory.src";
    
    NSString * pathMuArrayFindHistory = [NSHomeDirectory() stringByAppendingPathComponent:localPath];
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:array toFile:pathMuArrayFindHistory];
    
    if (flag) {
        
        NSLog(@"归档成功");
    }
    
    else
    {
        NSLog(@"归档不成功");
    }
    
}
#pragma mark - 解归档
- (NSMutableArray *)unAchive
{
    NSString *localPath = @"Documents/muArrayFindHistory.src";
    
    NSString * pathMuArrayFindHistory = [NSHomeDirectory() stringByAppendingPathComponent:localPath];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:pathMuArrayFindHistory];
    return arr;
    
}
#pragma mark - 搜索
- (IBAction)cancelBtnClick:(UIButton *)sender
{
    if (_searchText.text.length <=0) {
        Alert(@"请输入搜索关键字");
        return;
    }
    else
    {
    
        
        
        if (_dataArr.count>15) {
            [_dataArr insertObject:_searchText.text atIndex:0];
            
            [self achiveWithArray:_dataArr];
        }
        else
        {
            [_dataArr addObject:_searchText.text];
            
            [self achiveWithArray:_dataArr];
        }
        
        SearchResultController *searVc = [[SearchResultController alloc] init];
        
        searVc.searchTitle = _searchText.text;
        
        [self.navigationController pushViewController:searVc animated:YES];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 25;
    }
    else
    {
        return 0.01f;
    }
}
#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return _dataArr.count;
    }
    else
    {
        return 0;
    }
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 44;
    }
    else
    {
        return 0;
    }
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierStr = @"identifierStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierStr];
    }
    else
    {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text=[_dataArr objectAtQYQIndex:row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textColor = TCColorWords;
    return cell;
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchResultController *searVc = [[SearchResultController alloc] init];
    
    //searVc.searchTitle = _dataArr[indexPath.row];
     searVc.searchTitle = [_dataArr objectAtQYQIndex:indexPath.row];
    
    [self.navigationController pushViewController:searVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 25)];
        backView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-100, 25)];
        headLabel.text = @"最近搜索";
        headLabel.textColor = [UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];
        headLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:headLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth -55, 0, 50, 25);
        [btn setTitle:@"清空" forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:TCColor forState:UIControlStateNormal];
    
        [btn addTarget:self action:@selector(clearnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
        backView.userInteractionEnabled = YES;
        return backView;
    }
    else
    {
        return nil;
    }
}
#pragma mark - 点击清空历史记录的按钮
- (void)clearnBtnClick
{
    NSString *localPath = @"Documents/muArrayFindHistory.src";
    
    NSString * pathMuArrayFindHistory = [NSHomeDirectory() stringByAppendingPathComponent:localPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:pathMuArrayFindHistory error:nil];
    
    _dataArr = [NSMutableArray arrayWithArray:[self unAchive]];
    
    [self.SVTableView reloadData];
    
    Alert(@"清空历史记录成功");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
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
