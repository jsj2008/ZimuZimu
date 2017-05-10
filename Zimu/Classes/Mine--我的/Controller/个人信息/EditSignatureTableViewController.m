//
//  EditSignatureTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditSignatureTableViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "EditSignatureCell.h"

static NSString *identifier = @"EditSignatureCell";
@interface EditSignatureTableViewController ()

@end

@implementation EditSignatureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"个性签名";
    self.view.backgroundColor = themeGray;
    
    [self.tableView registerClass:[EditSignatureCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"保存" target:self action:@selector(saveNickName)];
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
    EditSignatureCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textView resignFirstResponder];
    if (self.signatureBlock) {
        self.signatureBlock(cell.textView.text);
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    EditSignatureCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
    EditSignatureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[EditSignatureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.signatureText = _signature;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
