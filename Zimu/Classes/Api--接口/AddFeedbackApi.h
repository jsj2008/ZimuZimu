//
//  AddFeedbackApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface AddFeedbackApi : YTKRequest

- (instancetype)initWithPhone:(NSString *)phone feedbackVal:(NSString *)feedbackVal systemName:(NSString *)systemName systemVersion:(NSString *)systemVersion deviceModel:(NSString *)deviceModel appVersion:(NSString *)appVersion;

@end
