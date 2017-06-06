//
//  FriendsMsgViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FriendsMsgViewController.h"
#import "FriendMsgCell.h"
#import "GetMyMsgApi.h"
#import "AcceptFriendApi.h"
#import "ZMBlankView.h"
#import "MBProgressHUD+MJ.h"
#import <MJRefresh.h>
#import "MyMsgModel.h"
#import "NewLoginViewController.h"

static NSString *cellId = @"FriendMsgCell";
@interface FriendsMsgViewController ()<UITableViewDelegate, UITableViewDataSource, FriendAcceptDelegate, LoginViewControllerDelegate>

@property (nonatomic, strong) UITableView *listView;

@property (nonatomic, strong) NSMutableArray *msgData;

@end

@implementation FriendsMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    self.title = @"消息";
    [self makeUI];
    // Do any additional setup after loading the view.
}

#pragma mark - makeUI
- (void)makeUI{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        
        //注册单元格
        UINib *nib = [UINib nibWithNibName:cellId bundle:[NSBundle mainBundle]];
        [_listView registerNib:nib forCellReuseIdentifier:cellId];
        
        _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getMsgNow)];
        _listView.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
        [_listView.mj_header beginRefreshing];
        
        _listView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_listView];
    }
}
#pragma  mark - 上下拉
- (void)getMsgNow{
    _msgData = [NSMutableArray array];
    _listView.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    [self getMsg:time];
}
- (void)getMore{
    MyMsgModel *msgModel = [MyMsgModel yy_modelWithJSON:[_msgData lastObject]];

    [self getMsg:(CGFloat)msgModel.createTime / 1000];
    NSLog(@"%.0f \n %zd", (NSTimeInterval)msgModel.createTime, msgModel.createTime);
}
#pragma mark - 列表代理数据源
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _msgData.count;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    MyMsgModel *msgModel = [MyMsgModel yy_modelWithJSON:_msgData[indexPath.row]];
    cell.nameString = msgModel.tUser.userName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.isFriend = indexPath.row < 20 ? YES : NO;
//    cell.isFriend = msgModel.sratus == 0 ? NO : YES;
    if (msgModel.sratus == 0) {
        cell.isFriend = NO;
    }else{
        cell.isFriend = YES;
    }
    cell.clickBtnDelegate =self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMsgNow];
    }];
    [self.view addSubview:blankview];
}
- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMsgNow];
    }];
    [self.view addSubview:blankview];
}
- (void)timeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMsgNow];
    }];
    [self.view addSubview:blankview];
}
- (void)lostSever{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMsgNow];
    }];
    [self.view addSubview:blankview];
}
#pragma mark - 点击同意
- (void)didClickAccceptBtn:(FriendMsgCell *)cell{
    NSIndexPath *index = [_listView indexPathForCell:cell];
    [self acceptFriend:index.row];
//    _msgData[index.row][@"sratus"] = @1;
    cell.isFriend = YES;
    NSLog(@"%zd", index.row);
}

#pragma mark - 消息列表获取
- (void)getMsg:(NSTimeInterval)time{
    GetMyMsgApi *getMsgApi = [[GetMyMsgApi alloc] initWithEndTime:[NSString stringWithFormat:@"%.0f", time]];
    [getMsgApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
//        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", jsonData);
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            [_listView.mj_footer endRefreshing];
            [_listView.mj_header endRefreshing];
            [self noData];
            return ;
        }else{
            BOOL isTrue = [dataDic[@"isTrue"] boolValue];
            if (!isTrue) {
                [self login];
                return;
            }
            NSArray *nowData = dataDic[@"items"];
            [_msgData addObjectsFromArray:nowData];
            if (_msgData.count == 0) {
                [self noData];
            }else{
                [_listView reloadData];
                [_listView.mj_footer endRefreshing];
                [_listView.mj_header endRefreshing];
                if (nowData.count < 10) {
                    [_listView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }

        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request.error.code == -1009) {
            [self noNet];
        }else if (request.error.code == -1011){
            [self timeOut];
        }else{
            [self lostSever];
        }
    }];
}

//点击同意网络请求
- (void)acceptFriend:(NSInteger)index{
    MyMsgModel *msgModel = [MyMsgModel yy_modelWithJSON:_msgData[index]];
    AcceptFriendApi *getMsgApi = [[AcceptFriendApi alloc] initWithFromUser:msgModel.fromUser];
    [getMsgApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        //        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", jsonData);
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            return ;
        }else{
            //如果返回添加成功则改变状态
            if ([dataDic[@"isTrue"] integerValue] == 1) {
                _msgData[index][@"sratus"] = @1;
                [MBProgressHUD showMessage_WithoutImage:@"添加成功" toView:self.view];
            }else{
                [MBProgressHUD showMessage_WithoutImage:@"添加失败" toView:self.view];
            }
                
        }
        [_listView reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
    }];

}
#pragma mark - 重新登录
- (void)login{
    //未登录，跳转至登录页
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    newLoginVC.delegate = self;
    [self presentViewController:newLoginVC animated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//LoginViewControllerDelegate
- (void)loginSuccess{
    [self getMsg:[[NSDate date] timeIntervalSince1970]];
}
@end
