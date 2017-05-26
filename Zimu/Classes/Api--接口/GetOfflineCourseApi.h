//
//  GetOfflineCourseApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetOfflineCourseApi : YTKRequest

- (instancetype)initWithCategoryId:(NSString *)categoryId;

@end
