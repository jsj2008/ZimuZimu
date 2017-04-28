//
//  ParentSchoolListModel.h
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParentSchoolItem :NSObject
@property (nonatomic , copy) NSString                       *id;
@property (nonatomic , copy) NSString                       *title;
@property (nonatomic , copy) NSString                       *picture;
@property (nonatomic , copy) NSString                       *type;
@property (nonatomic , assign) NSInteger                     readtimes;
@property (nonatomic , copy) NSString                       *createTime;


@end

@interface ParentSchoolModel :NSObject
@property (nonatomic , assign) BOOL                              isTrue;
@property (nonatomic , copy) NSString                           *message;
@property (nonatomic , strong) NSArray<ParentSchoolItem *>      *items;

@end
