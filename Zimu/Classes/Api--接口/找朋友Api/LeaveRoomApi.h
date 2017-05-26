//
//  LeaveRoomApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface LeaveRoomApi : YTKRequest
- (instancetype)initWithRoomId:(NSString *)roomId;
@end
