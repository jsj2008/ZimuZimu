//
//  OrderModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderUserModel :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * areaName;
@property (nonatomic , copy) NSString              * userQq;
@property (nonatomic , copy) NSString              * userWechat;
@property (nonatomic , copy) NSString              * userPhone;
@property (nonatomic , copy) NSString              * userSex;
@property (nonatomic , copy) NSString              * targeral;
@property (nonatomic , copy) NSString              * idNo;
@property (nonatomic , copy) NSString              * isExp;
@property (nonatomic , copy) NSString              * areaId;
@property (nonatomic , copy) NSString              * balance;
@property (nonatomic , copy) NSString              * latestSubscription;
@property (nonatomic , copy) NSString              * userImg;
@property (nonatomic , copy) NSString              * expert;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * cityId;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * provinceId;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , copy) NSString              * provinceName;
@property (nonatomic , copy) NSString              * age;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * cityName;
@property (nonatomic , copy) NSString              * userWeibo;
@property (nonatomic , copy) NSString              * userId;

@end

@interface OrderOfflineCourseModel :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * courseName;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * areaId;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * courseId;
@property (nonatomic , copy) NSString              * signUpTime;
@property (nonatomic , copy) NSString              * stopTime;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * endRegTime;
@property (nonatomic , copy) NSString              * provinceId;
@property (nonatomic , copy) NSString              * cityId;
@property (nonatomic , copy) NSString              * startTime;         //课程时间
@property (nonatomic , copy) NSString              * categoryId;

@end

@interface OrderModel :NSObject
@property (nonatomic , copy) NSString              * orderPrice;        //价格
@property (nonatomic , copy) NSString              * orderId;           //订单编号
@property (nonatomic , copy) NSString              * userId;            //用户ID
@property (nonatomic , copy) NSString              * status;            //订单状态（0:待付款  1:已付款）
@property (nonatomic , copy) NSString              * payTime;           //支付时间
@property (nonatomic , copy) NSString              * createTime;        //订单创建时间
@property (nonatomic , copy) NSString              * referee;           //推荐人
@property (nonatomic , copy) NSString              * charge;            //订单charge
@property (nonatomic , copy) NSString              * areaId;
@property (nonatomic , copy) NSString              * pingppId;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , strong) OrderUserModel              * user;
@property (nonatomic , copy) NSString              * cityId;
@property (nonatomic , copy) NSString              * provinceId;
@property (nonatomic , strong) OrderOfflineCourseModel              * offlineCourse;
@property (nonatomic , copy) NSString              * offCourseId;
@property (nonatomic , copy) NSString              * provinceName;
@property (nonatomic , copy) NSString              * payPlafrom;
@property (nonatomic , copy) NSString              * imgUrl;            //图片
@property (nonatomic , copy) NSString              * successTime;
@property (nonatomic , copy) NSString              * cityName;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * offCourseOrderId;  //订单ID

@end
