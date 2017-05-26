//
//  AddFeedbackApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AddFeedbackApi.h"

@implementation AddFeedbackApi{
    NSString *_phone;
    NSString *_feedbackVal;
    NSString *_systemName;
    NSString *_systemVersion;
    NSString *_deviceModel;
    NSString *_appVersion;
}

- (instancetype)initWithPhone:(NSString *)phone feedbackVal:(NSString *)feedbackVal systemName:(NSString *)systemName systemVersion:(NSString *)systemVersion deviceModel:(NSString *)deviceModel appVersion:(NSString *)appVersion{
    self = [super init];
    if (self) {
        _phone = phone;
        _feedbackVal = feedbackVal;
        _systemName = systemName;
        _systemVersion = systemVersion;
        _deviceModel = deviceModel;
        _appVersion = appVersion;
    }
    return self;
}

- (NSString *)requestUrl{
    return AddFeedbackURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    return @{@"phone":_phone,
             @"feedbackVal":_feedbackVal,
             @"systemName":_systemName,
             @"systemVersion":_systemVersion,
             @"deviceModel":_deviceModel,
             @"appVersion":_appVersion};
}

@end
