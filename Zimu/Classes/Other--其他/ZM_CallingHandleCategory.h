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

@property (nonatomic, assign) ZMChatRole role;   //进入房间的角色
@property (nonatomic, copy) NSString *users;     //发送邀请的用户id串，当且仅当用户为房主时需要
@property (nonatomic, copy) NSString *roomName;  //外面传进来的房间名,如果是房主则从接口中拿，其他人外面传进来

+ (instancetype)shareInstance;

- (instancetype)initWithRole:(ZMChatRole) role;

//开始通话，前提是role已经设置好，roomName设置好
- (void)startChat;

//跳转到聊天页面
- (void)jumpToChatRoom;

+ (void)jumpToWaitVC;

//获取当前window最上层的VC
+ (UIViewController*)curTopViewController;

@end
