//
//  EditCityTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditCityTableViewController.h"
#import "MyInfoSetTableViewController.h"
#import "EditCityApi.h"
#import "CityModel.h"
#import "MBProgressHUD+MJ.h"
#import "EditAddressApi.h"
#import "NewLoginViewController.h"
#import "ZMBlankView.h"

static NSString *identifier = @"cityCell";
@interface EditCityTableViewController ()

@property (nonatomic, strong) NSMutableArray *cityModelArray;
@property (nonatomic, copy) NSString *cityId;

@end

@implementation EditCityTableViewController

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
    return _cityModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    CityModel *cityModel = _cityModelArray[indexPath.row];
    cell.textLabel.text = cityModel.areaName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CityModel *cityModel = _cityModelArray[indexPath.row];
    _cityId = [NSString stringWithFormat:@"%@",cityModel.cityId];
    
    [self updateAddressInfo];
    //发送通知，传递省、市
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *address = [NSString stringWithFormat:@"%@ %@",_province, cell.textLabel.text];
    NSDictionary *userInfo = @{@"address":address};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProvinceCityNotification" object:nil userInfo:userInfo];
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
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        CityDataModel *cityDataModel = [CityDataModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = cityDataModel.isTrue;
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self login];
            return;
        }
        NSLog(@"dataDic : %@",dataDic);
        
        NSArray *vcs = self.navigationController.viewControllers;
        
        NSInteger index = 1;
        for (UIViewController *viewController in vcs) {
            if([viewController isKindOfClass:[MyInfoSetTableViewController class]]){
                index = [vcs indexOfObject:viewController];
                break;
            }
        }
        
        [self.navigationController popToViewController:vcs[index] animated:YES];
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
            [self netTimeOut];
            
        }
    }];
}

#pragma mark - login
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - 空白页
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:NO btnClick:^(ZMBlankView *blView) {
        [self getCityData];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getCityData];
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getCityData];
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getCityData];
    }];
    [self.view addSubview:blankview];
}


@end
