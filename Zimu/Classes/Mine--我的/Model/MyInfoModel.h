//
//  MyInfoModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInfoModel :NSObject

@property (nonatomic , copy) NSString              * userImg;           //头像
@property (nonatomic , copy) NSString              * userName;          //昵称
@property (nonatomic , copy) NSString              * age;               //年龄
@property (nonatomic , copy) NSString              * userPhone;         //手机号
@property (nonatomic , copy) NSString              * userSex;           //性别
@property (nonatomic , copy) NSString              * areaName;          //地区

@property (nonatomic , copy) NSString              * cityId;            //城市ID
@property (nonatomic , copy) NSString              * provinceId;        //省份ID
@property (nonatomic , copy) NSString              * userId;            //用户ID
@property (nonatomic , copy) NSString              * birthday;          //生日
@property (nonatomic , copy) NSString              * targeral;
@property (nonatomic , copy) NSString              * idNo;
@property (nonatomic , copy) NSString              * isExp;             //是否为专家
@property (nonatomic , copy) NSString              * areaId;            //
@property (nonatomic , copy) NSString              * balance;
@property (nonatomic , copy) NSString              * latestSubscription;
@property (nonatomic , copy) NSString              * expert;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * email;             //email
@property (nonatomic , copy) NSString              * provinceName;      //省份名称
@property (nonatomic , copy) NSString              * cityName;          //城市名
@property (nonatomic , copy) NSString              * createTime;        //注册时间
@property (nonatomic , copy) NSString              * userQq;            //QQ
@property (nonatomic , copy) NSString              * userWechat;        //微信
@property (nonatomic , copy) NSString              * userWeibo;         //微博

@end
