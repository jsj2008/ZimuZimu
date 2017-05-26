//
//  CreateChatRoomApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface CreateChatRoomApi : YTKRequest
- (instancetype)initWithUserId:(NSString *)userId num:(NSInteger) num;
@end
