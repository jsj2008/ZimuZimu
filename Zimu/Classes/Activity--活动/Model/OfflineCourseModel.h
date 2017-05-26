//
//  OfflineCourseModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfflineCourseModel :NSObject

@property (nonatomic , copy) NSString              * courseName;            //课程名称
@property (nonatomic , copy) NSString              * categoryName;          //课程类别名称
@property (nonatomic , copy) NSString              * address;               //地址
@property (nonatomic , copy) NSString              * provinceName;          //省名
@property (nonatomic , copy) NSString              * cityName;              //城市名
@property (nonatomic , copy) NSString              * courseId;              //课程ID
@property (nonatomic , copy) NSString              * startTime;             //课程开始时间
@property (nonatomic , copy) NSString              * createTime;            //课程创建时间
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * status;                
@property (nonatomic , copy) NSString              * provinceId;
@property (nonatomic , copy) NSString              * cityId;
@property (nonatomic , copy) NSString              * categoryId;

@end
