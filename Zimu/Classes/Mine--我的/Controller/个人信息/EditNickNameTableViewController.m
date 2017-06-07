//
//  EditNickNameTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditNickNameTableViewController.h"
#import "EditNickNameCell.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "EditNickNameApi.h"
#import "MBProgressHUD+MJ.h"
#import "NewLoginViewController.h"
#import "ZMBlankView.h"

static NSString *identifier = @"EditNickNameCell";
@interface EditNickNameTableViewController ()

@end

@implementation EditNickNameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"昵称";
    self.view.backgroundColor = themeGray;
    
    [self.tableView registerClass:[EditNickNameCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"保存" target:self action:@selector(updateNickNameNetWorkApply)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    EditNickNameCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField resignFirstResponder];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    EditNickNameCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditNickNameCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[EditNickNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.text = _nickName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


#pragma mark - 网络请求
- (void)updateNickNameNetWorkApply{
    EditNickNameCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSLog(@"nickName : %@",cell.textField.text);
    EditNickNameApi *editNickNameApi = [[EditNickNameApi alloc]initWithUserName:cell.textField.text];
    [editNickNameApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self login];
            return;
        }
        if (self.nickNameBlock) {
            self.nickNameBlock(cell.textField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netTimeOut];
            
        }
    }];
}

#pragma mark - login
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


#pragma mark - 空白页
- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self updateNickNameNetWorkApply];
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self updateNickNameNetWorkApply];
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self updateNickNameNetWorkApply];
    }];
    [self.view addSubview:blankview];
}

@end
