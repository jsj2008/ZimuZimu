//
//  EditCityApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface EditCityApi : YTKRequest

- (instancetype)initWithProvinceID:(NSString *)provinceId;

@end
