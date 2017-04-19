//
//  BaseViewController.h
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/*网络状态变化处理*/
//使用wifi
- (void)wifi;
//使用移动数据
- (void)mobileData;
//没有网络
- (void)noNet;

@end
