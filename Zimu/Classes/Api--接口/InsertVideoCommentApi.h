//
//  InsertVideoCommentApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface InsertVideoCommentApi : YTKRequest

- (instancetype)initWithCommentVal:(NSString *)commentVal videoId:(NSString *)videoId;

@end
