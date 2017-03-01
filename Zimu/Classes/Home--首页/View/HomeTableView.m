//
//  HomeTableView.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeArrayDataSource.h"
#import "Masonry.h"
#import "TestViewController.h"
#import "UIView+ViewController.h"

@interface HomeTableView ()<UITableViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style homeArrayDataSource:(HomeArrayDataSource *)homeArrayDataSource{
    self = [super initWithFrame:frame style:style];
    if (self) {        
        
        _titleArray = homeArrayDataSource.titleArray;
        self.backgroundColor = themeGray;
        
        self.dataSource = homeArrayDataSource;
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self sethiddenExtraLine];
    }
    return self;
}

//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"cellText : %@",cell.textLabel.text);
    NSLog(@"section : %li  row : %li",indexPath.section,indexPath.row);
    
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.viewController.navigationController pushViewController:testVC animated:YES];
    NSLog(@"viewc : %@",self.viewController);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeGray;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, 150, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = themeBlack;
    label.text = _titleArray[section];
    [view addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 5 - 16, 7, 16, 16)];
    imageView.image = [UIImage imageNamed:@"home_more"];
    [view addSubview:imageView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}



- (void)sethiddenExtraLine{
    UIView *view = [[UIView alloc]init];
    
    self.tableFooterView = view;
}



@end
