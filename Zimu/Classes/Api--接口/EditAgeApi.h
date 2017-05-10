//
//  EditAgeApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface EditAgeApi : YTKRequest

- (instancetype)initWithAge:(NSString *)age;

@end
