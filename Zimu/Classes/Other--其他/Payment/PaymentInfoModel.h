//
//  PaymentInfoModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentInfoModel :NSObject

@property (nonatomic , copy) NSString              * title;         //标题
@property (nonatomic , copy) NSString              * courseId;      //课程ID
@property (nonatomic , copy) NSString              * price;         //课程价格
@property (nonatomic , copy) NSString              * time;          //课程时间
@property (nonatomic , copy) NSString              * address;       //课程地址

@end

