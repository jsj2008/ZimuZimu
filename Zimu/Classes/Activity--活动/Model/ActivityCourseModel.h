//
//  ActivityCourseModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityCourseModel :NSObject

@property (nonatomic , copy) NSString              * courseName;
@property (nonatomic , copy) NSString              * courseIntro;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * orderNum;          //已报名人数
@property (nonatomic , copy) NSString              * applyNum;          //总人数

@end
