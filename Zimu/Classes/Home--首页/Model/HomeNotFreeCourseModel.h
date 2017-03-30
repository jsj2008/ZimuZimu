//
//  HomeNotFreeCourseModel.h
//  Zimu
//
//  Created by Redpower on 2017/3/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeNotFreeCourseItems :NSObject
@property (nonatomic , copy) NSString              * courseName;
@property (nonatomic , assign) NSInteger              courseScore;
@property (nonatomic , copy) NSString              * courseId;
@property (nonatomic , assign) NSInteger              coursePrice;
@property (nonatomic , copy) NSString              * expName;
@property (nonatomic , copy) NSString              * profile;
@property (nonatomic , assign) NSInteger              readNum;
@property (nonatomic , copy) NSString              * categoryName;

@end

@interface HomeNotFreeCourseModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<HomeNotFreeCourseItems *>              * items;

@end
