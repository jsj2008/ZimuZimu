//
//  EditSexTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditSexTableViewController.h"
#import "EditSexApi.h"
#import "MBProgressHUD+MJ.h"
#import "NewLoginViewController.h"
#import "ZMBlankView.h"

static NSString *identifier = @"sexCell";
@interface EditSexTableViewController (){
    NSInteger _selectIndex;
    NSInteger _sexIndex;
}



@end

@implementation EditSexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"性别";
    self.view.backgroundColor = themeGray;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorColor = themeGray;

    if ([_sex isEqualToString:@"男"]) {
        _selectIndex = 0;
    }else{
        _selectIndex = 1;
    }
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"男";
    }else{
        cell.textLabel.text = @"女";
    }
    if (indexPath.row == _selectIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectIndex = indexPath.row;
    
    
    if (_selectIndex == 0) {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        _sexIndex = 1;      //男
    }else{
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        _sexIndex = 0;      //女
    }

    [self updateAgeNetWorkApply];
}


#pragma mark - 网络请求
- (void)updateAgeNetWorkApply{
    EditSexApi *editSexApi = [[EditSexApi alloc]initWithUserSex:_sexIndex];
    [editSexApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
        if (_sexIndex == 0) {
            _sex = @"女";
        }else{
            _sex = @"男";
        }
        if (self.sexBlock) {
            self.sexBlock(_sex);
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
        [self updateAgeNetWorkApply];
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self updateAgeNetWorkApply];
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self updateAgeNetWorkApply];
    }];
    [self.view addSubview:blankview];
}

@end
