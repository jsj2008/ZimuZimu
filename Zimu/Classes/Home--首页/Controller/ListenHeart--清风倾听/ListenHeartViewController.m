//
//  ListenHeartViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListenHeartViewController.h"
#import "ListenHeartTableView.h"

@interface ListenHeartViewController ()

@property (nonatomic, strong) ListenHeartTableView *listenHeartTableView;
@property (nonatomic, strong) UIView *callPhoneView;

@end

@implementation ListenHeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"清风倾听";
    self.view.backgroundColor = themeGray;
    
    [self setupListenHeartTableView];
    
    [self setupCallPhoneView];
}

- (void)setupListenHeartTableView{
    _listenHeartTableView = [[ListenHeartTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_listenHeartTableView];
}

- (void)setupCallPhoneView{
    _callPhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 64, kScreenWidth, 64)];
    _callPhoneView.backgroundColor = themeWhite;
    [self.view addSubview:_callPhoneView];
    
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, 0, _callPhoneView.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_callPhoneView.layer addSublayer:line];
    
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callButton.frame = CGRectMake(_callPhoneView.width * 0.2, (_callPhoneView.height - 40)/2.0, _callPhoneView.width * 0.6, 40);
    [callButton setBackgroundColor:themeYellow];
    [callButton setTitle:@"一键咨询" forState:UIControlStateNormal];
    [callButton setTitleColor:themeBlack forState:UIControlStateNormal];
    [callButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    callButton.titleLabel.font = [UIFont systemFontOfSize:15];
    callButton.layer.cornerRadius = 5;
    callButton.layer.masksToBounds = YES;
    [callButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    
    [_callPhoneView addSubview:callButton];
}

- (void)callPhone{
    NSLog(@"打个电话");
}

@end
