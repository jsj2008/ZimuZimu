//
//  ZM_FriendCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

//每个cell的不同状态
typedef NS_ENUM(NSInteger, friendViewState) {
    friendViewStateNormal = 0,              // 普通展示状态
    friendViewStateChoosing,                // 选择中
    friendViewStateChoosingSelected,        //选择中已经被选中
    friendViewStateChoosingDisSelected      //选择中未被选中
    
};

@interface ZM_FriendCell : UICollectionViewCell

//图片的链接，必须包含前缀
@property (nonatomic, copy) NSString *imgUrlString;
//用户的名字
@property (nonatomic, copy) NSString *nameString;

@property (nonatomic, assign) friendViewState state;

@end
