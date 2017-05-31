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

static NSString *identifier = @"CompleteOrderCell";
@interface CompleteOrderTableViewController ()<CompleteOrderCellDelegate>

@property (nonatomic, strong) NSMutableArray *orderModelArray;

@end

@implementation CompleteOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CompleteOrderCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getCompleteOrderListData)];
    [self.tableView.mj_header beginRefreshing];
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


#pragma mark - 下拉获取数据
- (void)getCompleteOrderListData{
    //获取当前时间戳
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.0f",timeInterval];
    QueryAppUserOrderCompleteListApi *queryAppUserOrderCompleteListApi = [[QueryAppUserOrderCompleteListApi alloc]initWithEndTime:time status:@"1"];
    [queryAppUserOrderCompleteListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            return;
        }
        if (_orderModelArray) {
            [_orderModelArray removeAllObjects];
            _orderModelArray = nil;
        }
        NSArray *dataArray = dataDic[@"items"];
        if (dataArray.count != 0 && dataArray != nil) {
            _orderModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            for (NSDictionary *dic in dataArray) {
                OrderModel *orderModel = [OrderModel yy_modelWithDictionary:dic];
                [_orderModelArray addObject:orderModel];
            }
        }
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.tableView.mj_header endRefreshing];
        
    }];
}

//上拉加载
- (void)loadMoreData{
    //拿到当前tableView数据数组，取出最后一条数据的时间戳，用这个时间戳去请求更多数据
    NSMutableArray *nowDataArray = [NSMutableArray arrayWithArray:_orderModelArray];
    OrderOfflineCourseModel *model = nowDataArray.lastObject;
    NSString *lastTimeStamp = model.createTime;
    
    QueryAppUserOrderCompleteListApi *queryAppUserOrderListApi = [[QueryAppUserOrderCompleteListApi alloc]initWithEndTime:lastTimeStamp status:@"1"];
    [queryAppUserOrderListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错，请稍后再试" toView:nil];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:nil];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            return;
        }
        
        NSArray *dataArray = dataDic[@"items"];
        if (!dataArray.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }else if (dataArray.count < 10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        for (NSDictionary *dic in dataArray) {
            OrderModel *orderModel = [OrderModel yy_modelWithDictionary:dic];
            [nowDataArray addObject:orderModel];
        }
        _orderModelArray = nowDataArray;
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.tableView.mj_footer endRefreshing];
        
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            
            return;
        }
        //刷新数据
        [self getCompleteOrderListData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}

#pragma mark - 重新登录
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
