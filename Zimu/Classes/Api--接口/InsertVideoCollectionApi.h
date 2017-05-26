//
//  InsertVideoCollectionApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface InsertVideoCollectionApi : YTKRequest

- (instancetype)initWithVideoId:(NSString *)videoId;

@end
