//
//  GetArticleByPrimaryKeyApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetArticleByPrimaryKeyApi : YTKRequest

- (instancetype)initWithArticleId:(NSString *)articleId;

@end
