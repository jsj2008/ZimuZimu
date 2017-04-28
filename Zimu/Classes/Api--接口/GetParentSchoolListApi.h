//
//  GetParentSchoolListModel.h
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetParentSchoolListApi : YTKRequest

- (instancetype)initWithEndTime:(NSString *)endTime;

@end
