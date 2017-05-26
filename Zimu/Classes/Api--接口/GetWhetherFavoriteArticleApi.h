//
//  GetWhetherFavoriteArticleApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetWhetherFavoriteArticleApi : YTKRequest

- (instancetype)initWithArticleId:(NSString *)articleId;


@end
