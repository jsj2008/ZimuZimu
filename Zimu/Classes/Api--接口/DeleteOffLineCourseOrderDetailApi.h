//
//  DeleteOffLineCourseOrderDetailApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface DeleteOffLineCourseOrderDetailApi : YTKRequest

- (instancetype)initWithOffCourseOrderId:(NSString *)offCourseOrderId;

@end

#define DeleteOffLineCourseOrderDetailURL @"appOrder/check/deleteOffLineCourseOrderDetail.do"   //删除订单 (参数:offCourseOrderId、userToken)
