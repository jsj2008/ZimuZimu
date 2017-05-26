//
//  QueryOffLineCourseOrderDetailApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface QueryOffLineCourseOrderDetailApi : YTKRequest

- (instancetype)initWithOffCourseOrderId:(NSString *)offCourseOrderId;

@end
