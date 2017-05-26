//
//  QueryMyQuestionApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface QueryMyQuestionApi : YTKRequest

- (instancetype)initWithEndTime:(NSString *)endTime;

@end
