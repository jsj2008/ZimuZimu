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

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self obseverNet];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)obseverNet{
    NetWorkStatuesManager *netManager = [[NetWorkStatuesManager alloc] init];
    netManager.appRechabilituDelegate = self;
}
- (void)connectToWIFI{
    [self wifi];
}
- (void)connectToWan{
    [self mobileData];
}
- (void)lostConnect{
    [self noNet];
}
- (void)wifi{
    
}
- (void)mobileData{
    
}
- (void)noNet{
    
}
@end
