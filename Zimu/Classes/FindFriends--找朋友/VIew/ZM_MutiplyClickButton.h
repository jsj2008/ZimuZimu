//
//  ZM_MutiplyClickButton.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZM_MutiplyClickButtonDelegate <NSObject>

//在这个代理方法里面做每个index下的处理
- (void)didClickBtnWithIndex:(NSInteger) index;

@end

@interface ZM_MutiplyClickButton : UIButton

//当前的状态位置，不能修改，不然容易报错
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, weak) id<ZM_MutiplyClickButtonDelegate> delegate;

/*
    dataSource是从前至后的Btn状态的数组
    当前仅支持title文字的变化
 */
- (instancetype)initWithDataSource:(NSArray *)dataSource;


///*
//    进入下一个状态,暂时弃用
// */
//- (void)didClickButton;

//返回上次的状态
//如果返回上一个状态则需要在用户界面做相应的返回处理，不然只有按钮返回了，其他并未改变，实际上的界面和功能会有不对应
- (void)revertLastState;

//初始化button状态
- (void)initBtnState;
@end
