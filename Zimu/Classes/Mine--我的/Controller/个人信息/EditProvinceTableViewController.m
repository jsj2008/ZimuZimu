//
//  EditProvinceTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditProvinceTableViewController.h"
#import "EditCityTableViewController.h"
#import "EditProvinceApi.h"
#import "ProvinceModel.h"
#import "MBProgressHUD+MJ.h"
#import "NewLoginViewController.h"

static NSString *identifier = @"provinceCell";
@interface EditProvinceTableViewController ()

@property (nonatomic, strong) NSMutableArray *provinceModelArray;

@end

@implementation EditProvinceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地区";
    self.view.backgroundColor = themeGray;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorColor = themeGray;
    
    [self getProvinceData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _provinceModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ProvinceModel *model = _provinceModelArray[indexPath.row];
    cell.textLabel.text = model.areaName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditCityTableViewController *editCityVC = [[EditCityTableViewController alloc]init];
    ProvinceModel *provinceModel = _provinceModelArray[indexPath.row];
    editCityVC.provinceId = [NSString stringWithFormat:@"%@",provinceModel.cityId];
    editCityVC.province = provinceModel.areaName;
    [self.navigationController pushViewController:editCityVC animated:YES];
}


#pragma mark - 网络请求
- (void)getProvinceData{
    EditProvinceApi *editProvinceApi = [[EditProvinceApi alloc]init];
    [editProvinceApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        ProvinceDataModel *provinceDataModel = [ProvinceDataModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = provinceDataModel.isTrue;
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self login];
            return;
        }
        NSArray *provinceDataArray = provinceDataModel.items;
        _provinceModelArray = [NSMutableArray arrayWithCapacity:provinceDataArray.count];
        for (NSDictionary *dic in provinceDataArray) {
            ProvinceModel *provinceModel = [ProvinceModel yy_modelWithDictionary:dic];
            [_provinceModelArray addObject:provinceModel];
        }
        [self.tableView reloadData];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}

#pragma mark - login
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}



@end
