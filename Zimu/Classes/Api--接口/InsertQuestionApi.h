//
//  InsertQuestionApi.h
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface InsertQuestionApi : YTKRequest

- (instancetype)initWithQuestionTitle:(NSString *)questionTitle categoryId:(NSString *)categoryId questionVal:(NSString *)questionVal;

@end


