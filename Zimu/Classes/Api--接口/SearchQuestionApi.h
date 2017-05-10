//
//  SearchQuestionApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface SearchQuestionApi : YTKRequest

- (instancetype)initWithQuestionTitle:(NSString *)questionTitle;

@end
