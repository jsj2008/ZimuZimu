//
//  FriendProvinceTableViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FriendProvinceTableViewController.h"

#import "FriendCityTableViewController.h"
#import "EditProvinceApi.h"
#import "ProvinceModel.h"
#import "MBProgressHUD+MJ.h"

static NSString *identifier = @"provinceCell";
@interface FriendProvinceTableViewController ()

@property (nonatomic, strong) NSMutableArray *provinceModelArray;

@end

@interface FriendProvinceTableViewController ()

@end

@implementation FriendProvinceTableViewController

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
    return _provinceModelArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"全国";
    }else{
        
        ProvinceModel *model = _provinceModelArray[indexPath.row - 1];
        cell.textLabel.text = model.areaName;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSDictionary *userInfo = @{@"addressId":@"",
                                   @"addressNme":@"全国"
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProvinceCityFriendNotification" object:nil userInfo:userInfo];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        FriendCityTableViewController *editCityVC = [[FriendCityTableViewController alloc]init];
        ProvinceModel *provinceModel = _provinceModelArray[indexPath.row - 1];
        editCityVC.provinceId = [NSString stringWithFormat:@"%@",provinceModel.cityId];
        editCityVC.province = provinceModel.areaName;
        [self.navigationController pushViewController:editCityVC animated:YES];
    }
}


#pragma mark - 网络请求
- (void)getProvinceData{
    EditProvinceApi *editProvinceApi = [[EditProvinceApi alloc]init];
    [editProvinceApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        ProvinceDataModel *provinceDataModel = [ProvinceDataModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = provinceDataModel.isTrue;
        if (!isTrue) {
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
        [MBProgressHUD showMessage_WithoutImage:@"网络出错" toView:nil];
    }];
}


@end

