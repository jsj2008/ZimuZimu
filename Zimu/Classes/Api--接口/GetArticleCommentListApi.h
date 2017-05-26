//
//  GetArticleCommentListApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetArticleCommentListApi : YTKRequest

- (instancetype)initWithArticleId:(NSString *)articleId;


@end
