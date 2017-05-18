//
//  ExpertDetailModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertInfo :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * workTime;
@property (nonatomic , copy) NSString              * profile;
@property (nonatomic , copy) NSString              * expId;
@property (nonatomic , copy) NSString              * expEdu;
@property (nonatomic , copy) NSString              * qualification;
@property (nonatomic , copy) NSString              * expertPrice;
@property (nonatomic , copy) NSString              * isRecommend;
@property (nonatomic , copy) NSString              * good;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * expLevel;
@property (nonatomic , copy) NSString              * expTitle;
@property (nonatomic , copy) NSString              * experience;
@property (nonatomic , copy) NSString              * sort;

@end

@interface ExpertDetailModel :NSObject
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
@property (nonatomic , strong) ExpertInfo          * expert;
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
