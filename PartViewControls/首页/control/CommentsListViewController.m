//
//  CommentsListViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/24.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CommentsListViewController.h"
#import "CommentsListCell.h"
#import "leaveWordsModel.h"

@interface CommentsListViewController ()<CLCellFirstLabelTapDelegate,UITextFieldDelegate>

@end

@implementation CommentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerForKeyboardNotifications];
    [self toGetTheMessage:self.dreamid];
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self uiConfig];
    [self createAnswerViewList];
}

#pragma mark - 获取留言505
- (void)toGetTheMessage:(NSString *)dreamid
{
    if(_dataArray==nil)
    {
    _dataArray = [[NSMutableArray alloc]init];
    }
    [_dataArray removeAllObjects];
    
   // NSDictionary *wParamDict = @{@"dreamid":dreamid};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:dreamid,@"dreamid", nil];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"505" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            NSArray *resultArr = (NSArray *)resultDict;
            for (NSDictionary *dict in resultArr)
            {
                leaveWordsModel *model = [[leaveWordsModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            if(_dataArray.count>0)
            {
                [_CommentsListTable reloadData];
            }
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
}


- (void)uiConfig
{
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    self.title = @"留言板";
    
    self.CommentsListTable.delegate = self;
    self.CommentsListTable.dataSource = self;
    self.CommentsListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setExtraCellLineHidden:self.CommentsListTable];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 创建评论框
-(void)createAnswerViewList
{
    _answerBackView = [[UIView alloc]init];
    _answerBackView.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:233/255.0 alpha:1];
    _answerBackView.frame  =CGRectMake(0, ScreenHeight, ScreenWidth, 50);
    [self.view addSubview:_answerBackView];
    
    _answerTextField = [[UITextField alloc] init];
    _answerTextField.frame  =CGRectMake(10, 5, ScreenWidth-20, 40);
    _answerTextField.delegate = self;
    _answerTextField.returnKeyType =UIReturnKeyDone;
    _answerTextField.layer.masksToBounds = YES;
    _answerTextField.layer.cornerRadius = 5;
    _answerTextField.placeholder = @"在此输入您的留言";
    _answerTextField.backgroundColor = [UIColor whiteColor];
    [_answerBackView addSubview:_answerTextField];
    
}

#pragma mark - 发送留言
- (void)sentMessageClick
{
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    [_answerTextField becomeFirstResponder];
}


#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_dataArray.count>0)
    {
        //leaveWordsModel *model = [_dataArray objectAtIndex:indexPath.row];
        leaveWordsModel *model = [_dataArray objectAtQYQIndex:indexPath.row];
        
        NSArray *replyWord = model.replyWord;
        if(replyWord.count>0)
        {
            return 91;
        }
        else
        {
            return 56;
        }
    }
    else
    {
        return 0;
    }
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"CommentsListCell";
    CommentsListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentsListCell" owner:self options:nil]objectAtQYQIndex:0];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    if(_dataArray.count>0)
    {
       // [cell showUIViewWithModel:[_dataArray objectAtIndex:indexPath.row]];
        [cell showUIViewWithModel:[_dataArray objectAtQYQIndex:indexPath.row]];
    }
    return cell;
}

#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _leaveModel = [_dataArray objectAtQYQIndex:indexPath.row];
    [self sentMessageClick];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGPoint contentOffsetPoint = self.ExceptionalListTable.contentOffset;
}

- (void)CLCellFirstLabelTap:(NSInteger)textTag
{
    NSLog(@"textTag ==  %ld",(long)textTag);
}

#pragma mark - 注册检测键盘的通知
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardHide:) name: UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 键盘出现函数
- (void)keyboardWasShown:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    [UIView animateWithDuration:0.1 animations:^{
        _answerBackView.frame  =CGRectMake(0, ScreenHeight-50-64-keyboardSize.height, ScreenWidth, 50);
    }];
}
#pragma mark - 键盘关闭函数
-(void)keyboardHide: (NSNotification *)notif
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.1 animations:^{
        
        _answerBackView.frame  =CGRectMake(0, ScreenHeight, ScreenWidth, 50);
        
        //self.TCNewTableView.contentOffset = CGPointMake(0, oldPointy-64);
    }];
}
#pragma mark - return收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *contentString = _answerTextField.text;
    if(contentString.length>0)
    {
        //提交回复的函数
        NSString *nickname = [PersonInfo sharePersonInfo].nickname;
        [self toRespondToCommentsWithWordid:_leaveModel.parentID dreamid:_leaveModel.dreamID nickname:nickname content:contentString];
        _answerTextField.text = @"";
    }
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.1 animations:^{
        
        _answerBackView.frame  =CGRectMake(0, ScreenHeight, ScreenWidth, 50);
    }];
    
    return YES;
}

#pragma mark - 获取留言505
- (void)toRespondToCommentsWithWordid:(NSString *)wordid dreamid:(NSString *)dreamid nickname:(NSString *)nickname content:(NSString *)content
{
    NSString *userid = [PersonInfo sharePersonInfo].userId;
    _dataArray = [[NSMutableArray alloc]init];
//    NSDictionary *wParamDict = @{@"userid":userid,@"wordid":wordid,@"dreamid":dreamid,@"nickname":nickname,@"content":content};
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",wordid,@"wordid",dreamid,@"dreamid",nickname,@"nickname",content,@"content", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"506" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            Alert(@"回复成功");
            [self toGetTheMessage:self.dreamid];
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
