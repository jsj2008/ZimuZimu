//
//  SearchFriendDetailViewController.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, searchFriendStyle) {
    searchFriendStyleId = 0,              // 精确查找
    searchFriendStyleMsg                 // 条件查询
    
};

@interface SearchFriendDetailViewController : UIViewController

- (instancetype)initWithStyle:(searchFriendStyle)style;

@end
