//
//  HomeImageModel.h
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeImageItems :NSObject
@property (nonatomic , copy)    NSString              *title;
@property (nonatomic , assign)  NSInteger              imgNo;
@property (nonatomic , copy)    NSString              *imgUrl;

@end

@interface HomeImageModel :NSObject
@property (nonatomic , assign)  BOOL                            isTrue;
@property (nonatomic , copy)    NSString                        *message;
@property (nonatomic , strong)  NSArray<HomeImageItems *>       *items;

@end
