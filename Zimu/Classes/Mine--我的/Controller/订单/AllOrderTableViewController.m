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
#import "ZMBlankView.h"

static NSString *notPayIdentifier = @"NotPayOrderCell";
static NSString *completeIdentifier = @"CompleteOrderCell";

@interface AllOrderTableViewController ()<NotPayOrderCellDelegate, CompleteOrderCellDelegate, PaymentChannelViewDelegate, LoginViewControllerDelegate>

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
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
    
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
    QueryAppUserOrderListApi *queryAppUserOrderListApi = [[QueryAppUserOrderListApi alloc]initWithEndTime:timeInterval];
    [queryAppUserOrderListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
    NSDictionary *payOrderModelDic = @{@"offlineCourseOrderId":orderModel.offCourseOrderId,
                                          @"channel":orderModel.payPlafrom,
                                          @"charge":orderModel.charge};
    
    PaymentInfoModel *paymentInfoModel = [PaymentInfoModel yy_modelWithDictionary:modelDic];
    PayOrderModel *payOrderModel = [PayOrderModel yy_modelWithDictionary:payOrderModelDic];
    _paymentChannelView = [UIView paymentChannelView];
    _paymentChannelView.chargePay = YES;
    _paymentChannelView.payOrderModel = payOrderModel;
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
            [MBProgressHUD showMessage_WithoutImage:@"请稍后再试" toView:self.view];
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



#pragma mark - PaymentChannelViewDelegate
- (void)paymentViewFinishPayWithResult:(NSString *)result payOrderModel:(PayOrderModel *)payOrderModel{
    [_popup dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        [self refresh];
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
