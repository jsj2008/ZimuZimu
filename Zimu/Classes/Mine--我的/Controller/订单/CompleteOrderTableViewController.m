//
//  CompleteOrderTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CompleteOrderTableViewController.h"
#import "CompleteOrderCell.h"
#import "OrderDetailViewController.h"
#import "QueryAppUserOrderCompleteListApi.h"
#import "OrderModel.h"
#import "MBProgressHUD+MJ.h"
#import "NewLoginViewController.h"
#import "DeleteOffLineCourseOrderDetailApi.h"
#import <MJRefresh.h>
#import "ZMBlankView.h"

static NSString *identifier = @"CompleteOrderCell";
@interface CompleteOrderTableViewController ()<CompleteOrderCellDelegate, LoginViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *orderModelArray;

@end

@implementation CompleteOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CompleteOrderCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //已完成
    CompleteOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderModel *orderModel = _orderModelArray[indexPath.section];
    cell.orderModel = orderModel;
    cell.delegate = self;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 9) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc]init];
    OrderModel *orderModel = _orderModelArray[indexPath.section];
    orderDetailVC.orderId = orderModel.offCourseOrderId;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

#pragma mark - 获取数据
//下拉刷新
- (void)refresh{
    if (_orderModelArray) {
        [_orderModelArray removeAllObjects];
        _orderModelArray = nil;
    }
    _orderModelArray = [NSMutableArray array];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];    //获取当前时间戳
    [self getData:timeInterval];
}
//上拉加载
- (void)getMore{
    OrderOfflineCourseModel *model = _orderModelArray.lastObject;
    NSInteger lastTimestamp = [model.createTime integerValue];
    [self getData:lastTimestamp/1000];
}
- (void)getData:(NSInteger)timestamp{
    NSString *timeInterval = [NSString stringWithFormat:@"%li",timestamp];
    QueryAppUserOrderCompleteListApi *queryAppUserOrderCompleteListApi = [[QueryAppUserOrderCompleteListApi alloc]initWithEndTime:timeInterval status:@"1"];
    [queryAppUserOrderCompleteListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            return;
        }
        
        NSArray *dataArray = dataDic[@"items"];
        if (dataArray.count != 0 && dataArray != nil) {
            for (NSDictionary *dic in dataArray) {
                OrderModel *orderModel = [OrderModel yy_modelWithDictionary:dic];
                [_orderModelArray addObject:orderModel];
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (dataArray.count < 10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.tableView reloadData];
            
        }
        if (_orderModelArray.count == 0) {
            [self noData];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.tableView.mj_header endRefreshing];
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
            [self netLostServer];
        }
        
    }];
}


#pragma mark - CompleteOrderCellDelete
- (void)completeOrderCellDeleteOrder:(CompleteOrderCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    OrderModel *orderModel = _orderModelArray[indexPath.section];
    
    //UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除订单吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteOrderNetWork:orderModel.offCourseOrderId];
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 删除订单
- (void)deleteOrderNetWork:(NSString *)orderId{
    DeleteOffLineCourseOrderDetailApi *deleteOrderApi = [[DeleteOffLineCourseOrderDetailApi alloc]initWithOffCourseOrderId:orderId];
    [deleteOrderApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            
            return;
        }
        //刷新数据
        [self refresh];
        
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
            [self netLostServer];
            
        }
    }];
}

#pragma mark - 重新登录
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    loginVC.delegate = self;
    [self presentViewController:loginVC animated:YES completion:nil];
}
//LoginViewControllerDelegate
- (void)loginSuccess{
    [self refresh];
}


#pragma mark - 空白页
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:NO btnClick:^(ZMBlankView *blView) {
        [self refresh];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self refresh];
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self refresh];
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self refresh];
    }];
    [self.view addSubview:blankview];
}

@end
