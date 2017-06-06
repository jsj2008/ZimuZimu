//
//  ActivityOrderCompleteViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityOrderCompleteViewController.h"
#import "ActivityOrderSuccessView.h"
#import "ActivityOrderFailView.h"
#import "MBProgressHUD+MJ.h"
#import "GetOfflineCourseByIdApi.h"
#import "OfflineCourseModel.h"
#import "ActivityOrderViewController.h"
#import "ZMBlankView.h"
#import "ActivityDetailViewController.h"
#import "ZM_CallingHandleCategory.h"

@interface ActivityOrderCompleteViewController ()<ActivityOrderSuccessViewDelegate, ActivityOrderFailViewDelegate>

@property (nonatomic, strong) ActivityOrderSuccessView *succesView; //报名成功页
@property (nonatomic, strong) ActivityOrderFailView *failedView;    //支付失败页

@end

@implementation ActivityOrderCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;

    if ([_result isEqualToString:@"success"]) {
        //支付成功
        [self setupSuccessView];
        [self getActivityData];
    }else if ([_result isEqualToString:@"fail"] || [_result isEqualToString:@"cancel"]){
        //支付失败
        [self setupFialedView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


/**
 *  报名成功页
 *  succesView;
 */
- (void)setupSuccessView{
    _succesView = [[ActivityOrderSuccessView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _succesView.backgroundColor = themeWhite;
    _succesView.delegate = self;
    [self.view addSubview:_succesView];
}


#pragma mark - ActivityOrderSuccessViewDelegate
- (void)activityOrderSuccessViewQuit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)activityOrderSuccessViewCheckOrder{
    NSLog(@"查看订单");
    ActivityOrderViewController *orderVC = [[ActivityOrderViewController alloc]init];
    orderVC.orderId = self.payOrderModel.offlineCourseOrderId;
    [self dismissViewControllerAnimated:YES completion:^{
        ActivityDetailViewController *activityDetailVC = (ActivityDetailViewController *)[ZM_CallingHandleCategory curTopViewController];
        [activityDetailVC.navigationController pushViewController:orderVC animated:YES];
        
    }];

}

#pragma mark - 报名成功获取活动数据
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getActivityData];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getActivityData];
    }];
    [self.view addSubview:blankview];
}
- (void)getActivityData{
    GetOfflineCourseByIdApi *getOfflineCourseByIdApi = [[GetOfflineCourseByIdApi alloc]initWithCourseId:_courseId];
    [getOfflineCourseByIdApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            [self noData];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"暂无活动数据" toView:self.view];
            [self noData];
            return;
        }
        if (!dataDic[@"object"]) {
            [self noData];
        }else{
            OfflineCourseModel *offlineCourseModel = [OfflineCourseModel yy_modelWithDictionary:dataDic[@"object"]];
            _succesView.offlineCourseModel = offlineCourseModel;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //-1009 没网络 -1011请求超时  其他代码服务器错误
        if (request.error.code == -1009) {
            
        }else if (request.error.code == -1011){
            
        }else{
            
        }
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
    
}



/**
 *  支付失败页
 */
- (void)setupFialedView{
    _failedView = [[ActivityOrderFailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _failedView.backgroundColor = themeWhite;
    _failedView.delegate = self;
    [self.view addSubview:_failedView];
}

#pragma mark - ActivityOrderFailViewDelegate
- (void)activityOrderFailViewQuit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//重新支付
- (void)activityOrderFailViewPayAgain{
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.orderCompleteDelegate respondsToSelector:@selector(payAgainWithPayOrderModel:)]) {
        [self.orderCompleteDelegate payAgainWithPayOrderModel:self.payOrderModel];
    }
}





@end
