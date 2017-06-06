//
//  ActivityOrderViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityOrderViewController.h"
#import "OrderDetailTableView.h"
#import "QueryOffLineCourseOrderDetailApi.h"
#import "MBProgressHUD+MJ.h"
#import "OrderModel.h"
#import "NewLoginViewController.h"
#import "ZMBlankView.h"
<<<<<<< HEAD
#import "UIBarButtonItem+ZMExtension.h"
=======
>>>>>>> origin/master

@interface ActivityOrderViewController ()<LoginViewControllerDelegate>

@property (nonatomic, strong) OrderDetailTableView *orderDetailTableView;
@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) OrderModel *orderModel;


@end

@implementation ActivityOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.view.backgroundColor = themeGray;
    
    [self getOrderDetailData];
    
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationButtonReturn" title:@"" target:self action:@selector(returnBack)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
}

- (void)returnBack{
    NSArray *vcs = self.navigationController.viewControllers;
    
    NSInteger index = 1;
    for (UIViewController *viewController in vcs) {
        if([viewController isKindOfClass:NSClassFromString(@"HomeViewController")]){
            index = [vcs indexOfObject:viewController];
            break;
        }
    }
    
    [self.navigationController popToViewController:vcs[index] animated:YES];

}

#pragma mark - 获取订单详情
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}
- (void)timeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}
- (void)lostSever{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}

- (void)getOrderDetailData{
    QueryOffLineCourseOrderDetailApi *queryOffLineCourseOrderDetailApi = [[QueryOffLineCourseOrderDetailApi alloc]initWithOffCourseOrderId:_orderId];
    [queryOffLineCourseOrderDetailApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
<<<<<<< HEAD
            [self noData];
=======
//            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            [self lostSever];
>>>>>>> origin/master
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
//            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self noData];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            return;
        }
        
        _orderModel = [OrderModel yy_modelWithDictionary:dataDic[@"object"]];
<<<<<<< HEAD
        
        _orderDetailTableView = [[OrderDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain orderModel:_orderModel];
        [self.view addSubview:_orderDetailTableView];
        
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
            
=======
        if (!_orderModel.orderId) {
            [self noData];
        }else{
            _orderDetailTableView = [[OrderDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain orderModel:_orderModel];
            [self.view addSubview:_orderDetailTableView];
            
            [self setupPayButton];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request.error.code == -1009) {
            [self noNet];
        }else if (request.error.code == -1011){
            [self timeOut];
        }else{
            [self lostSever];
>>>>>>> origin/master
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
    [self getOrderDetailData];
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
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getOrderDetailData];
    }];
    [self.view addSubview:blankview];
}

@end
