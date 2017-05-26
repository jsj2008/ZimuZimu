//
//  SearchFriendByPhone.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface SearchFriendByPhone : YTKRequest
- (instancetype)initWithPhone:(NSString *)phone;
@end
