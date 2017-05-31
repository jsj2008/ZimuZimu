//
//  AllOrderTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AllOrderTableViewController.h"
#import "NotPayOrderCell.h"
#import "CompleteOrderCell.h"
#import "OrderDetailViewController.h"
#import "QueryAppUserOrderListApi.h"
#import "MBProgressHUD+MJ.h"
#import "OrderModel.h"
#import <MJRefresh.h>
#import "NewLoginViewController.h"
#import "PaymentInfoModel.h"
#import "DeleteOffLineCourseOrderDetailApi.h"

#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"
#import "SnailQuickMaskPopups.h"

static NSString *notPayIdentifier = @"NotPayOrderCell";
static NSString *completeIdentifier = @"CompleteOrderCell";

@interface AllOrderTableViewController ()<NotPayOrderCellDelegate, CompleteOrderCellDelegate, PaymentChannelViewDelegate>

@property (nonatomic, strong) NSMutableArray *orderModelArray;
@property (nonatomic, strong) PaymentChannelView *paymentChannelView;
@property (nonatomic, strong) SnailQuickMaskPopups *popup;

@end

@implementation AllOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NotPayOrderCell" bundle:nil] forCellReuseIdentifier:notPayIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompleteOrderCell" bundle:nil] forCellReuseIdentifier:completeIdentifier];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getAllOrderListData)];
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
    OrderModel *orderModel = _orderModelArray[indexPath.section];
    NSInteger status = [orderModel.status integerValue];
    if (status == 0) {
        //待付款
        NotPayOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:notPayIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderModel = orderModel;
        cell.delegate = self;
        
        return cell;
        
    }else if (status == 1){
        //已完成
        CompleteOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:completeIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderModel = orderModel;
        cell.delegate = self;
        
        return cell;
        
    }else{
        return nil;
    }
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
- (void)getAllOrderListData{
    //获取当前时间戳
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.0f",timeInterval];
    QueryAppUserOrderListApi *queryAppUserOrderListApi = [[QueryAppUserOrderListApi alloc]initWithEndTime:time];
    [queryAppUserOrderListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错，请稍后再试" toView:self.view];
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
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];
    }];
}

//上拉加载
- (void)loadMoreData{
    //拿到当前tableView数据数组，取出最后一条数据的时间戳，用这个时间戳去请求更多数据
    NSMutableArray *nowDataArray = [NSMutableArray arrayWithArray:_orderModelArray];
    OrderOfflineCourseModel *model = nowDataArray.lastObject;
    NSString *lastTimeStamp = model.createTime;

    QueryAppUserOrderListApi *queryAppUserOrderListApi = [[QueryAppUserOrderListApi alloc]initWithEndTime:lastTimeStamp];
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
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];
    }];
}

#pragma mark - 重新登录
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


#pragma mark - NotPayOrderCellDelegate
//重新支付
- (void)notPayOrderCellToPay:(NotPayOrderCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    OrderModel *orderModel = _orderModelArray[indexPath.section];
    OrderOfflineCourseModel *orderCourseModel = orderModel.offlineCourse;
    NSInteger timestamp = [orderCourseModel.startTime integerValue];
    NSDictionary *modelDic = @{@"title":orderCourseModel.courseName,
                               @"courseId":orderModel.offCourseId,
                               @"price":orderModel.orderPrice,
                               @"time":[self handleDateWithTimeStamp:timestamp],
                               @"address":[NSString stringWithFormat:@"%@ %@",orderModel.provinceName, orderCourseModel.address]};
    
    PaymentInfoModel *paymentInfoModel = [PaymentInfoModel yy_modelWithDictionary:modelDic];
    _paymentChannelView = [UIView paymentChannelView];
    _paymentChannelView.charge = orderModel.charge;
    _paymentChannelView.chargePay = YES;
    _paymentChannelView.delegate = self;
    _paymentChannelView.paymentInfoModel = paymentInfoModel;
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_paymentChannelView];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];
}
//删除订单
- (void)notPayOrderCellDeleteOrder:(NotPayOrderCell *)cell{
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
        [self getAllOrderListData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}



#pragma mark - PaymentChannelViewDelegate
- (void)paymentViewFinishPayWithResult:(NSString *)result{
    [_popup dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        [self getAllOrderListData];
    }];
}

- (void)loginFailed{
    [_popup dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        [self login];
    }];
}




- (NSString *)handleDateWithTimeStamp:(NSInteger)timeStamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000.0];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


@end
