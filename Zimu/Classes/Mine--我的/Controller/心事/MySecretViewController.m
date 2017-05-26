//
//  MySecretViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MySecretViewController.h"
#import "MySecretTableView.h"
#import "MBProgressHUD+MJ.h"
#import "QueryMyQuestionApi.h"

@interface MySecretViewController ()

@property (nonatomic, strong) MySecretTableView *tableView;
@end

@implementation MySecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的心事";
    [self makeTableView];
    
    //获取我的心事
    [self getMySecretListData];
    
}


- (void)makeTableView{
    if (!_tableView) {
        _tableView = [[MySecretTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
}


#pragma mark - 获取我的心事数据
- (void)getMySecretListData{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.0f",timeInterval];
    QueryMyQuestionApi *queryMySecretApi = [[QueryMyQuestionApi alloc]initWithEndTime:time];
    [queryMySecretApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
            return;
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
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
