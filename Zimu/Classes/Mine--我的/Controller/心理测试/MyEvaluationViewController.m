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
#import "MyPsyTestListApi.h"

@interface MyEvaluationViewController ()

@property (nonatomic, strong) EvaluationListTableView *evaluationListTableView;

@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的心理测试";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
            return ;
        }else{
            if ([dataDic[@"message"] isEqualToString:@"success"]) {
                _evaluationListTableView.testListData = dataDic[@"items"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_evaluationListTableView reloadData];
                });
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
    }];

}
@end
