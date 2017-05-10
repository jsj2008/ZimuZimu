//
//  InsertCommentApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface InsertCommentApi : YTKRequest

- (instancetype)initWithCommentVal:(NSString *)commentVal questionId:(NSString *)questionId;

@end
