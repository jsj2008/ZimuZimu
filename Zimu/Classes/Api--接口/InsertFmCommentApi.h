//
//  InsertFmCommentApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface InsertFmCommentApi : YTKRequest


- (instancetype)initWithFmId:(NSString *)fmId commentVal:(NSString *)commentVal;


@end
