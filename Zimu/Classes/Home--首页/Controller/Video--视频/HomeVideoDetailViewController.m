//
//  HomeVideoDetailViewController.m
//  Zimu
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeVideoDetailViewController.h"

@interface HomeVideoDetailViewController ()

@end

@implementation HomeVideoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    self.title = @"视频详情";
    
    //设备旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    UIDevice *device = [UIDevice currentDevice] ;
    
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            break;
            
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;
            
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"home键在右");
            
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"home键在左");
            
            break;
            
        case UIDeviceOrientationPortrait:
            NSLog(@"home键在下");
            
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"home键在上");
            break;
            
        default:
            NSLog(@"无法辨识");
            break;
    }
    
}

@end
