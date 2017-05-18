//
//  AppQueryVideoApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface AppQueryVideoApi : YTKRequest

- (instancetype)initWithVideoId:(NSString *)videoId;


@end
