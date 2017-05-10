//
//  ZM_CallingHandleCategory.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_CallingHandleCategory.h"

#import "PLMediaChiefPKViewController.h"
#import "PLMediaViewerPKViewController.h"
#import "SingleChiefViewController.h"
#import "SingleViewerViewController.h"

#import "ZMChatAlertViewController.h"

@interface ZM_CallingHandleCategory ()
@property (nonatomic, assign) ZMChatRole role;   //进入房间的角色
@end

@implementation ZM_CallingHandleCategory

- (instancetype)initWithRole:(ZMChatRole)role{
    self = [super init];
    if (self) {
        _role = role;
        
        
    }
    return self;
}

- (void)jumpToChatRoom{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (_role) {
            case ZMChatRoleGroupChief:
            {
                PLMediaChiefPKViewController *vc = [[PLMediaChiefPKViewController alloc] init];
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:vc animated:YES completion:nil];
            }
                break;
                return;
            case ZMChatRoleGroupViewers:
            {
                PLMediaViewerPKViewController *vc = [[PLMediaViewerPKViewController alloc] init];
                vc.userType = PLMediaUserTypeSecondChief;
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:vc animated:YES completion:nil];
            }
                break;
                return;
            case ZMChatRoleSingleChief:
            {
                SingleChiefViewController *vc = [[SingleChiefViewController alloc] init];
                vc.audioOnly = NO;
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:vc animated:YES completion:nil];
            }
                break;
                return;
            case ZMChatRoleSingleViewer:
            {
                SingleViewerViewController *vc = [[SingleViewerViewController alloc] init];
                vc.userType = PLMediaUserTypeSecondChief;
                vc.audioOnly = NO;
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:vc animated:YES completion:nil];
            }
                break;
                return;
            default:
                break;
        }
    });
}
+ (void)jumpToWaitVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        ZMChatAlertViewController *chatAlertVC = [[ZMChatAlertViewController alloc] init];
        
        [[ZM_CallingHandleCategory curTopViewController] presentViewController:chatAlertVC animated:YES completion:nil];
    });
}

//获取当前显示的VC
+ (UIViewController*)curTopViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return [self topViewControllerWithRootViewController:window.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController1 = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController1.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
