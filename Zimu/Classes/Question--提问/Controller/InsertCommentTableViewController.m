//
//  InsertCommentTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertCommentTableViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "InsertCommentCell.h"
#import "InsertCommentApi.h"
#import "MBProgressHUD+MJ.h"

static NSString *identifier = @"InsertCommentCell";
@interface InsertCommentTableViewController ()

@end

@implementation InsertCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"写评论";
    self.view.backgroundColor = themeGray;
    
    [self.tableView registerClass:[InsertCommentCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"保存" target:self action:@selector(insertComment)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - 提交评论
- (void)insertComment{
    InsertCommentCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *commentText = cell.textView.text;
    
    if (commentText.length == 0) {
        [MBProgressHUD showMessage_WithoutImage:@"情填写评论后提交" toView:self.view];
        return;
    }
    
    InsertCommentApi *insertCommentApi = [[InsertCommentApi alloc]initWithCommentVal:commentText questionId:_questionId];
    [insertCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
            return;
        }
        
        //发送通知，刷新评论列表
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCommentList" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
    }];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    InsertCommentCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textView resignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    InsertCommentCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textView becomeFirstResponder];
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
    InsertCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[InsertCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



@end
