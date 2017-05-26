//
//  GetRoomTokenApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetRoomTokenApi : YTKRequest
- (instancetype)initWithUserId:(NSString *)userId role:(NSString *)role roomName:(NSString *)roomName;
@end
