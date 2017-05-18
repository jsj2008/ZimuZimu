//
//  GetVideoCommentApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetVideoCommentApi : YTKRequest

- (instancetype)initWithVideoId:(NSString *)videoId;

@end
