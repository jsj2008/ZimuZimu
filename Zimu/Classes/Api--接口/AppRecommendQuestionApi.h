//
//  AppRecommendQuestionApi.h
//  Zimu
//
//  Created by Redpower on 2017/6/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface AppRecommendQuestionApi : YTKRequest

- (instancetype)initWithCategoryId:(NSString *)categoryId questionId:(NSString *)questionId;


@end
