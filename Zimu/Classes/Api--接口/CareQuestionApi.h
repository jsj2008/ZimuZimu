//
//  CareQuestionApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface CareQuestionApi : YTKRequest

- (instancetype)initWithQuestionId:(NSString *)questionId;

@end
