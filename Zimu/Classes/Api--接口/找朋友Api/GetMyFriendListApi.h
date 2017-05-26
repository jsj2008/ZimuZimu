//
//  GetMyFriendListApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetMyFriendListApi : YTKRequest

- (instancetype)initWithUserName:(NSString *)userName;

@end
