//
//  FriendMsgCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendMsgCell;
@protocol FriendAcceptDelegate <NSObject>

- (void)didClickAccceptBtn:(FriendMsgCell *)cell;

@end

@interface FriendMsgCell : UITableViewCell

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *nameString;

@property (nonatomic, assign) BOOL isFriend;


@property (nonatomic, weak) id<FriendAcceptDelegate> clickBtnDelegate;

@end
