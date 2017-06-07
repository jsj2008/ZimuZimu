//
//  BaseViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BaseViewController.h"
#import "NetWorkStatuesManager.h"

@interface BaseViewController ()<AppRechabilityDelegate>

@property (nonatomic, strong)NetWorkStatuesManager *netManager;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self obseverNet];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)obseverNet{
    if (!_netManager){
        _netManager = [[NetWorkStatuesManager alloc] init];
        _netManager.appRechabilituDelegate = self;
    }
}
#pragma mark - AppRechabilityDelegate
- (void)connectToWIFI{
    [self wifi];
}
- (void)connectToWan{
    [self mobileData];
}
- (void)lostConnect{
    [self lostNet];
}

//外部实现的网络切换方法
- (void)wifi{
    
}
- (void)mobileData{
    
}
- (void)lostNet{
    
}

@end
