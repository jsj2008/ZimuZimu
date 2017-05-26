//
//  AddFriendApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface AddFriendApi : YTKRequest

- (instancetype)initWithUserId:(NSString *)userId;

@end
