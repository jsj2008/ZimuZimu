//代码地址：https://github.com/iosdeveloperSVIP/YMCitySelect
//原创：iosdeveloper赵依民
//邮箱：iosdeveloper@vip.163.com
//
//  YMCitySearch.m
//  YMCitySelect
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 YiMin. All rights reserved.
//

#import "YMCitySearch.h"
#import "YMCityModel.h"

@interface YMCitySearch ()

@end

@implementation YMCitySearch{
    NSMutableArray *_ym_cityArray;
    NSMutableArray *_ym_resultArray;
    NSBundle *_YMBundle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _YMBundle = [self getYMCitySelectBundle];
    [self ym_setCitys];
    _ym_resultArray = [NSMutableArray array];
}

-(void)ym_setCitys{
    NSString *path = [_YMBundle pathForResource:@"cities.plist" ofType:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
    _ym_cityArray = [NSMutableArray arrayWithCapacity:tempArray.count];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YMCityModel *cityModel = [[YMCityModel alloc] init];
        [cityModel setValuesForKeysWithDictionary:obj];
        [_ym_cityArray addObject:cityModel];
    }];
}

-(void)setYm_searchText:(NSString *)ym_searchText{
    _ym_searchText = ym_searchText;
    ym_searchText = [ym_searchText copy];
    ym_searchText = ym_searchText.lowercaseString;
    [_ym_resultArray removeAllObjects];
    for (YMCityModel *cityModel in _ym_cityArray) {
        if ([cityModel.name containsString:ym_searchText] || [cityModel.pinYin containsString:ym_searchText] || [cityModel.pinYinHead containsString:ym_searchText]) {
            [_ym_resultArray addObject:cityModel];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ym_resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ym_resultCitycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    YMCityModel *cityModel = _ym_resultArray[indexPath.row];
    cell.textLabel.text = cityModel.name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"有%zd个搜索结果",_ym_resultArray.count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMCityModel *cityModel = _ym_resultArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ym_searchCityResult" object:nil userInfo:@{@"ym_searchCityResultKey": cityModel.name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获取bundle地址
/** 获取YMCitySelect.bundle路径 */
- (NSBundle *)getYMCitySelectBundle{
    static NSBundle *searchBundle = nil;
    if (searchBundle == nil) {
        // 默认使用[NSBundle mainBundle]
        searchBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"YMCitySelect" ofType:@"bundle"]];
        // 如果使用pod导入，并且在Podfile中配置use_frameworks!则[NSBundle mainBundle] 加载不到YMCitySelect.framework中的YMCitySelect.bundle资源文件
        if (searchBundle == nil) { // 为空说明资源文件在YMCitySelect.framework中
            searchBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[YMCitySearch class]] pathForResource:@"YMCitySelect" ofType:@"bundle"]];
        }
    }
    return searchBundle;
}


@end
