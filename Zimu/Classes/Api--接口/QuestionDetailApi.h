//
//  QuestionDetailApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface QuestionDetailApi : YTKRequest

- (instancetype)initWithQuestionId:(NSString *)questionId;

@end
