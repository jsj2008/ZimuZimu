//
//  ZM_SelectSexView.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

//信息选择器代理
@protocol FriendsMsgDelegate <NSObject>

- (void)msgCollectEndedWithSex:(BOOL) sex age:(NSInteger) age;

@end


@interface ZM_SelectSexView : UIView

@property (nonatomic, weak) id<FriendsMsgDelegate> delegate;

/*
 *   sex性别：0 男  1女
 */
@property (nonatomic, assign) BOOL sex;

/*
 *   age年龄：数字代表年龄
 */
@property (nonatomic, assign) NSInteger age;


@end
