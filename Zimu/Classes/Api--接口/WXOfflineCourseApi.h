//
//  WXOfflineCourseApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface WXOfflineCourseApi : YTKRequest

- (instancetype)initWithOfflineCourseId:(NSString *)offlineCourseId offlineCourseName:(NSString *)offlineCourseName offCoursePrice:(NSString *)offCoursePrice channel:(NSString *)channel;

@end

