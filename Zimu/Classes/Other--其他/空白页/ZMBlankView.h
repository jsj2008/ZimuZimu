//
//  ZMBlankView.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZMBlankType) {
    ZMBlankTypeDefault = 0,         //默认状态
    ZMBlankTypeNoData = 1,          //么有数据
    ZMBlankTypeNoNet = 2,           //没有网络
    ZMBlankTypeNoFriend = 3,        //没有好友
    ZMBlankTypeTimeOut = 4,         //请求超时
    ZMBlankTypeLostSever = 5        //服务器异常
};


@interface ZMBlankView : UIView

typedef void(^ZMBlankBtnDidClick)(ZMBlankView *);
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame Type:(ZMBlankType)type afterClickDestory:(BOOL)shouldDestory btnClick:(ZMBlankBtnDidClick)btnClick;

@end
