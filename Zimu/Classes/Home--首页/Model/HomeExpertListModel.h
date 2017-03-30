//
//  HomeExpertListModel.h
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestSubscription :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * profile;
@property (nonatomic , copy) NSString              * type;

@end

@interface ExpertPrice :NSObject <NSCoding,NSCopying>
@property (nonatomic , assign) CGFloat              price;

@end

@interface Expert :NSObject <NSCoding,NSCopying>
@property (nonatomic , strong) ExpertPrice              * expertPrice;
@property (nonatomic , copy) NSString              * qualification;
@property (nonatomic , copy) NSString              * good;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * profile;
@property (nonatomic , copy) NSString              * experience;

@end

@interface HomeExpertItems :NSObject
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , strong) LatestSubscription              * latestSubscription;
@property (nonatomic , copy) NSString              * userId;
@property (nonatomic , strong) Expert              * expert;

@end

@interface HomeExpertListModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<HomeExpertItems *>              * items;

@end
