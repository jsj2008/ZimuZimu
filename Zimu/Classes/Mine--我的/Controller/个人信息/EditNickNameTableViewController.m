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

#pragma mark - 上传昵称
- (void)saveNickName{    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    EditNickNameCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField resignFirstResponder];
    if (self.nickNameBlock) {
        self.nickNameBlock(cell.textField.text);
    }
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
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
            return;
        }
        if (self.nickNameBlock) {
            self.nickNameBlock(cell.textField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
    }];
}



@end
