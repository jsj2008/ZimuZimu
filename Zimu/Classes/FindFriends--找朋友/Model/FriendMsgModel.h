//
//  FriendMsgModel.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendMsgModel : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger userSex;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *userImg;
@end
