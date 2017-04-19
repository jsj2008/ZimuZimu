//
//  HomeBannerModel.h
//  Zimu
//
//  Created by Redpower on 2017/3/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBannerItems :NSObject
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              imgNo;
@property (nonatomic , copy) NSString              * imgUrl;

@end

@interface HomeBannerModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<HomeBannerItems *>              * items;

@end
