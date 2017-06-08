//
//  FriendCityTableViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FriendCityTableViewController.h"
#import "MyInfoSetTableViewController.h"
#import "EditCityApi.h"
#import "CityModel.h"
#import "MBProgressHUD+MJ.h"
#import "EditAddressApi.h"
#import "SearchFriendDetailViewController.h"

static NSString *identifier = @"cityCell";
@interface FriendCityTableViewController ()

@property (nonatomic, strong) NSMutableArray *cityModelArray;
@property (nonatomic, copy) NSString *cityId;

@end

@implementation FriendCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地区";
    self.view.backgroundColor = themeGray;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorColor = themeGray;
    
    //获取城市列表数据
    [self getCityData];
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
    return _cityModelArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"全%@", _province];
    }else{
        CityModel *cityModel = _cityModelArray[indexPath.row - 1];
        cell.textLabel.text = cityModel.areaName;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *vcs = self.navigationController.viewControllers;
    
    NSInteger index = 1;
    for (UIViewController *viewController in vcs) {
        if([viewController isKindOfClass:[SearchFriendDetailViewController class]]){
            index = [vcs indexOfObject:viewController];
            break;
        }
    }
    
    [self.navigationController popToViewController:vcs[index] animated:YES];
    if (indexPath.row == 0) {
        NSDictionary *userInfo = @{@"addressId":_provinceId,
                                   @"addressNme":_province};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProvinceCityFriendNotification" object:nil userInfo:userInfo];
    }else{
        CityModel *cityModel = _cityModelArray[indexPath.row];
        _cityId = [NSString stringWithFormat:@"%@",cityModel.cityId];
        NSString *address = [NSString stringWithFormat:@"%@-%@", _province, cityModel.areaName];
        NSDictionary *userInfo = @{@"addressId":_cityId,
                                   @"addressNme":address};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProvinceCityFriendNotification" object:nil userInfo:userInfo];
    }
}

#pragma mark - 网络请求
//获取城市列表数据
- (void)getCityData{
    EditCityApi *editCityApi = [[EditCityApi alloc]initWithProvinceID:_provinceId];
    [editCityApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        CityDataModel *cityDataModel = [CityDataModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = cityDataModel.isTrue;
        if (!isTrue) {
            return;
        }
        NSArray *cityDataArray = cityDataModel.items;
        _cityModelArray = [NSMutableArray arrayWithCapacity:cityDataArray.count];
        for (NSDictionary *dic in cityDataArray) {
            CityModel *cityModel = [CityModel yy_modelWithDictionary:dic];
            [_cityModelArray addObject:cityModel];
        }
        [self.tableView reloadData];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [MBProgressHUD showMessage_WithoutImage:@"网络出错" toView:self.view];
    }];
}

//上传数据
- (void)updateAddressInfo{
    EditAddressApi *editAddressApi = [[EditAddressApi alloc]initWithProvinceId:_provinceId cityId:_cityId];
    [editAddressApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据上传失败，请稍后再试" toView:self.view];
    }];
}

@end
