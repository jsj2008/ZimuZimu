//
//  MyMsgModel.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUser :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * areaName;
@property (nonatomic , copy) NSString              * userWechat;
@property (nonatomic , copy) NSString              * userQq;
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
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , copy) NSString              * cityId;
@property (nonatomic , copy) NSString              * provinceId;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , copy) NSString              * provinceName;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * cityName;
@property (nonatomic , copy) NSString              * userWeibo;
@property (nonatomic , copy) NSString              * userId;

@end

@interface MyMsgModel :NSObject
@property (nonatomic , copy) NSString              * userId;    //我的信息
@property (nonatomic , assign) NSInteger              sratus;   //1是添加成功   0是未处理
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) TUser              * tUser;      //对方的信息
@property (nonatomic , copy) NSString              * userMessageId;
@property (nonatomic , copy) NSString              * fromUser;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , assign) NSInteger              createTime;

@end
