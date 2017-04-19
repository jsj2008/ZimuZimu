//
//  HomeFMModel.h
//  Zimu
//
//  Created by Redpower on 2017/3/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeFMItems :NSObject
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , assign) NSInteger              goodNum;
@property (nonatomic , copy) NSString              * fmId;
@property (nonatomic , assign) NSInteger              readNum;
@property (nonatomic , copy) NSString              * fmTitle;

@end

@interface HomeFMModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<HomeFMItems *>              * items;

@end
