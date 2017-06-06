//
//  MyEvaluationViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "EvaluationListTableView.h"
#import "UIImage+ZMExtension.h"
#import "MBProgressHUD+MJ.h"
#import "ZMBlankView.h"
#import "NewLoginViewController.h"
#import "MyPsyTestListApi.h"

@interface MyEvaluationViewController ()<LoginViewControllerDelegate>

@property (nonatomic, strong) EvaluationListTableView *evaluationListTableView;

@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的心理测试";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor = themeWhite;
    [self getMyPsyList];
    [self setupEvaluationListTableView];
    
}

/**
 *  evaluationListTableView
 */
- (void)setupEvaluationListTableView{
    _evaluationListTableView = [[EvaluationListTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_evaluationListTableView];
}

#pragma mark - 网络请求
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMyPsyList];
    }];
    [self.view addSubview:blankview];
}
- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMyPsyList];
    }];
    [self.view addSubview:blankview];
}
- (void)timeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMyPsyList];
    }];
    [self.view addSubview:blankview];
}
- (void)lostSever{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getMyPsyList];
    }];
    [self.view addSubview:blankview];
}
- (void)getMyPsyList{
    MyPsyTestListApi *listApi = [[MyPsyTestListApi alloc] init];
    
    [listApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            [self noData];
            return ;
        }else{
            BOOL isTrue = [dataDic[@"isTrue"] boolValue];
            if (!isTrue) {
                [self login];
                return;
            }
            _evaluationListTableView.testListData = dataDic[@"items"];
            if (_evaluationListTableView.testListData.count == 0) {
                [self noData];
            }else{
                [_evaluationListTableView reloadData];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //-1009 没网络 -1011请求超时  其他代码服务器错误
        if (request.error.code == -1009) {
            [self noNet];
        }else if (request.error.code == -1011){
            [self timeOut];
        }else{
            [self lostSever];
        }
    }];

}

#pragma mark - 重新登录
- (void)login{
    //未登录，跳转至登录页
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    newLoginVC.delegate = self;
    [self presentViewController:newLoginVC animated:YES completion:nil];
}
//LoginViewControllerDelegate
- (void)loginSuccess{
    [self getMyPsyList];
}

@end
