//
//  ZM_FriendsListView.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>


//每个cell的不同状态
typedef NS_ENUM(NSInteger, chooseState) {
    chooseStateNormal = 0,              // 普通展示状态
    chooseStateChoosing                 // 选择中
    
};

@protocol ZMFriendDelagate <NSObject>

- (void )didSelectItems:(NSDictionary *)items;

- (void)watchFriendDetailWithIndex:(NSInteger)index;

@end

@interface ZM_FriendsListView : UICollectionView

//数据，从VC网络请求来
@property (nonatomic, strong) NSArray *dataArray;
//是否是多选状态,从
@property (nonatomic, assign) BOOL isChooseFriends;
//是否开始选择好友的状态标识,作用同isChooseFriends
@property (nonatomic, assign) chooseState state;

@property (nonatomic, weak) id<ZMFriendDelagate> selectMoreDelegate;

@end
