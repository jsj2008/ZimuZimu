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
@property (nonatomic, assign)ZMNetState netState;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _netState = ZMNetStateDefault;
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
    if (_netState == ZMNetStateDefault) {
        _netChangeState = ZMNetChangeStateDefault;
    }else{
        switch (_netState) {
            case ZMNetStateWan:
            {
                _netChangeState = ZMNetChangeStateWanToWIFI;
            }
                break;
            case ZMNetStateLost:
            {
                _netChangeState = ZMNetChangeStateLostToWiFi;
            }
                break;

            default:
                break;
        }
    }
    _netState = ZMNetStateWIFI;
    [self wifi];
}
- (void)connectToWan{
    if (_netState == ZMNetStateDefault) {
        _netChangeState = ZMNetChangeStateDefault;
    }else{
        switch (_netState) {
            case ZMNetStateWIFI:
            {
                _netChangeState = ZMNetChangeStateWanToWIFI;
            }
                break;
            case ZMNetStateLost:
            {
                _netChangeState = ZMNetChangeStateLostToWan;
            }
                break;
                
            default:
                break;
        }
    }
    _netState = ZMNetStateWan;
    [self mobileData];
}
- (void)lostConnect{
    if (_netState == ZMNetStateDefault) {
        _netChangeState = ZMNetChangeStateDefault;
    }else{
        _netChangeState = ZMNetChangeStateLost;
    }
    _netState = ZMNetStateLost;
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
