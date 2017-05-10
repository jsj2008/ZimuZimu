//
//  ZM_CallingHandleCategory.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZMChatRole) {
    ZMChatRoleGroupChief = 0,   //多人聊天的房主
    ZMChatRoleGroupViewers = 1, //多人聊天的观众
    ZMChatRoleSingleChief = 2,  //单人聊天的房主
    ZMChatRoleSingleViewer = 3  //单人聊天的观众
};

@interface ZM_CallingHandleCategory : NSObject

- (instancetype)initWithRole:(ZMChatRole) role;

//跳转到聊天页面
- (void)jumpToChatRoom;

+ (void)jumpToWaitVC;

//获取当前window最上层的VC
+ (UIViewController*)curTopViewController;

@end
