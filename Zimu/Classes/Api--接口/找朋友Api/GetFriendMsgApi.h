//
//  GetFriendMsgApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetFriendMsgApi : YTKRequest
- (instancetype)initWithUserId:(NSString *)userId;
@end
