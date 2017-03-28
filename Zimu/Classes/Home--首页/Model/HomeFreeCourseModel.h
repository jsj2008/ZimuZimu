//
//  HomeFreeCourseModel.h
//  Zimu
//
//  Created by Redpower on 2017/3/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Items :NSObject
@property (nonatomic , copy) NSString              * courseName;
@property (nonatomic , assign) NSInteger              courseScore;
@property (nonatomic , copy) NSString              * courseId;
@property (nonatomic , copy) NSString              * courseImg;
@property (nonatomic , copy) NSString              * expName;
@property (nonatomic , copy) NSString              * profile;
@property (nonatomic , assign) NSInteger              readNum;
@property (nonatomic , copy) NSString              * categoryName;

@end

@interface HomeFreeCourseModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<Items *>              * items;

@end
