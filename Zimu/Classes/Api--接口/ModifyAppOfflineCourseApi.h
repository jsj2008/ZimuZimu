//
//  ModifyAppOfflineCourseApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface ModifyAppOfflineCourseApi : YTKRequest

- (instancetype)initWithOffCourseOrderId:(NSString *)offCourseOrderId channel:(NSString *)channel offlineCourseName:(NSString *)offlineCourseName;

@end
