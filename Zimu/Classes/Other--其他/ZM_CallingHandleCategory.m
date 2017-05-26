//
//  ZM_CallingHandleCategory.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//
//通话过程 房主--> 创建房间 -->                     获取房间信息 --> 进入房间 -->发推送 --> 离开房间
//      其他人--> 通过网络请求或者推送获取到通话请求--> 获取房间信息 --> 进入房间          --> 离开房间
#import "ZM_CallingHandleCategory.h"
#import "PLMediaChiefPKViewController.h"
#import "PLMediaViewerPKViewController.h"
#import "SingleChiefViewController.h"
#import "SingleViewerViewController.h"
#import "MBProgressHUD+MJ.h"
#import "ZMChatAlertViewController.h"

//通话用到的网络请求
#import "CreateChatRoomApi.h"
#import "CominRoomApi.h"
#import "GetRoomTokenApi.h"
#import "LeaveRoomApi.h"
#import "PushNotiToUsersApi.h"

@interface ZM_CallingHandleCategory ()

@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation ZM_CallingHandleCategory{
    //用于存储跳转的下个界面的信息
    NSString *_roomToken;
    NSString *_roomId;
    NSString *_pushUrl;
    NSString *_playUrl;
    NSString *_userId;
}
+ (instancetype)shareInstance{
    static ZM_CallingHandleCategory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZM_CallingHandleCategory alloc]init];
        
    });
    return instance;
}
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
                vc.roomName = _roomName;
                vc.roomToken = _roomToken;
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:vc animated:YES completion:nil];
            }
                break;
                return;
            case ZMChatRoleGroupViewers:
            {
                PLMediaViewerPKViewController *vc = [[PLMediaViewerPKViewController alloc] init];
                vc.userType = PLMediaUserTypeSecondChief;
                vc.roomName = _roomName;
                vc.roomToken = _roomToken;
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:vc animated:YES completion:nil];
            }
                break;
                return;
            case ZMChatRoleSingleChief:
            {
                SingleChiefViewController *vc = [[SingleChiefViewController alloc] init];
                vc.audioOnly = NO;
                vc.roomName = _roomName;
                vc.roomToken = _roomToken;
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:vc animated:YES completion:nil];
            }
                break;
                return;
            case ZMChatRoleSingleViewer:
            {
                SingleViewerViewController *vc = [[SingleViewerViewController alloc] init];
                vc.userType = PLMediaUserTypeSecondChief;
                vc.roomName = _roomName;
                vc.roomToken = _roomToken;
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
        if ([[ZM_CallingHandleCategory curTopViewController] isKindOfClass:[ZMChatAlertViewController class]]) {
            [[ZM_CallingHandleCategory curTopViewController] dismissViewControllerAnimated:NO completion:^{
                ZMChatAlertViewController *chatAlertVC = [[ZMChatAlertViewController alloc] init];
                [[ZM_CallingHandleCategory curTopViewController] presentViewController:chatAlertVC animated:YES completion:nil];
            }];
            
        }else{
            ZMChatAlertViewController *chatAlertVC = [[ZMChatAlertViewController alloc] init];
            
            [[ZM_CallingHandleCategory curTopViewController] presentViewController:chatAlertVC animated:YES completion:nil];
        }
    });
}
#pragma mark - 统一管理通话
- (void)startChat{
    if (_role == ZMChatRoleGroupChief || _role == ZMChatRoleSingleChief) {
        [self createRoom];
    }
    if (_role == ZMChatRoleGroupViewers || _role == ZMChatRoleSingleViewer) {
        [self getRoomToken];
    }
}
#pragma mark - 网络请求
- (void)createRoom{
    NSInteger num = (_role == ZMChatRoleSingleChief)?2:4;
    CreateChatRoomApi *createApi = [[CreateChatRoomApi alloc] initWithUserId:userToken num:num];
    [createApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        //        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络创建房间" toView:self.viewController.view];
            return ;
        }else{
            if ([dataDic[@"message"] isEqualToString:@"success"]) {
                _roomName = dataDic[@"object"];
                [self getRoomToken];
            }
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络创建房间1" toView:self.viewController.view];
    }];
}
- (void)getRoomToken{
    GetRoomTokenApi *getRoomTokenApi = [[GetRoomTokenApi alloc] initWithUserId:userToken role:@"user" roomName:_roomName];
    [getRoomTokenApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        //        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络roomToken" toView:self.viewController.view];
            return ;
        }else{
            if ([dataDic[@"message"] isEqualToString:@"success"]) {
                _roomToken = dataDic[@"object"];
                [self cominRoom];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络roomToken1" toView:self.viewController.view];
    }];

}
- (void)cominRoom{
    CominRoomApi *getRoomTokenApi = [[CominRoomApi alloc] initWithRoomId:_roomName];
    [getRoomTokenApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        //        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络进入房间" toView:self.viewController.view];
            return ;
        }else{
            if ([dataDic[@"message"] isEqualToString:@"success"]) {
//                _roomToken = dataDic[@"object"];
                if (_role == ZMChatRoleGroupChief || _role == ZMChatRoleSingleChief) {
                    [self pushNoti];
                    
                }else{
                    [self jumpToChatRoom];
                }
            }

        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络进入房间1" toView:self.viewController.view];
    }];

}
- (void)leaveRoom{
    LeaveRoomApi *getRoomTokenApi = [[LeaveRoomApi alloc] initWithRoomId:_roomId];
    [getRoomTokenApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        //        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.viewController.view];
            return ;
        }else{
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)pushNoti{
    PushNotiToUsersApi *getRoomTokenApi = [[PushNotiToUsersApi alloc] initWithType:@"videoChat" users:_users roomName:_roomName];
    [getRoomTokenApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        //        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络推送" toView:self.viewController.view];
            return ;
        }else{
            [self jumpToChatRoom];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络推送1" toView:self.viewController.view];
    }];
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

- (UIViewController *)viewController{
    return [ZM_CallingHandleCategory curTopViewController];
}
@end
