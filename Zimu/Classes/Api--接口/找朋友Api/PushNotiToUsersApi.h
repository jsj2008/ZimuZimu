//
//  PushNotiToUsersApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PushNotiToUsersApi : YTKRequest
- (instancetype)initWithType:(NSString *)type users:(NSString *)users roomName:(NSString *)roomName  num:(NSString *)num;
@end
