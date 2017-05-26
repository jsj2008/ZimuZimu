//
//  ActivityAddressListModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityAddressListModel :NSObject

@property (nonatomic , copy) NSString              * courseName;
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , copy) NSString              * areaId;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * cityName;              //市
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * courseId;              //课程活动ID
@property (nonatomic , copy) NSString              * signUpTime;
@property (nonatomic , copy) NSString              * stopTime;
@property (nonatomic , copy) NSString              * address;               //区
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * endRegTime;
@property (nonatomic , copy) NSString              * areaName;
@property (nonatomic , copy) NSString              * provinceName;          //省
@property (nonatomic , copy) NSString              * provinceId;
@property (nonatomic , copy) NSString              * cityId;
@property (nonatomic , copy) NSString              * startTime;
@property (nonatomic , copy) NSString              * categoryId;

@end
