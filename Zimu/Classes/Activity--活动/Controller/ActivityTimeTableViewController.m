//
//  ActivityTimeTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityTimeTableViewController.h"
#import "GetOfflineCourseApi.h"
#import "MBProgressHUD+MJ.h"
#import "ActivityAddressListModel.h"

static NSString *identifier = @"activityAdderssTimeCell";
@interface ActivityTimeTableViewController ()

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation ActivityTimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择课程";
    self.view.backgroundColor = themeWhite;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self hideExtraLine];
    [self getActivityAddressListData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    ActivityAddressListModel *model = _modelArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@  %@",model.provinceName, model.address, [self handleDateWithTimeStamp:[model.startTime integerValue]]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ActivityAddressListModel *model = _modelArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(activityTimeTableViewControllerDidSelectAddress:courseId:)]) {
        [self.delegate activityTimeTableViewControllerDidSelectAddress:cell.textLabel.text courseId:model.courseId];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideExtraLine{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeWhite;
    self.tableView.tableFooterView = view;
}


#pragma mark - 获取数据
- (void)getActivityAddressListData{
    GetOfflineCourseApi *getOfflineCourseApi = [[GetOfflineCourseApi alloc]initWithCategoryId:_categoryId];
    [getOfflineCourseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"暂无数据" toView:self.view];
            return;
        }
        NSArray *listArray = dataDic[@"items"];
        if (listArray.count) {
            if (_modelArray) {
                [_modelArray removeAllObjects];
                _modelArray = nil;
            }
            _modelArray = [NSMutableArray arrayWithCapacity:listArray.count];
            for (NSDictionary *dic in listArray) {
                ActivityAddressListModel *model = [ActivityAddressListModel yy_modelWithDictionary:dic];
                [_modelArray addObject:model];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"暂无数据" toView:self.view];
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
