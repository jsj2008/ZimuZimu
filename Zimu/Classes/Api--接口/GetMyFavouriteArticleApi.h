//
//  GetMyFavouriteArticleApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetMyFavouriteArticleApi : YTKRequest
- (instancetype)initWithEndTime:(NSInteger)endTime;
@end
