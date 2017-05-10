//
//  InsertQuestionApi.h
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface InsertQuestionApi : YTKRequest

- (instancetype)initWithUserId:(NSString *)userId questionTitle:(NSString *)questionTitle keyWord:(NSString *)keyWord questionVal:(NSString *)questionVal;

@end


