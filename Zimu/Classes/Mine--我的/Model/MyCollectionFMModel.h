//
//  MyCollectionFMModel.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionFMModel : NSObject
@property (nonatomic , copy) NSString              * fmImg;
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , copy) NSString              * fmTitle;
@property (nonatomic , assign) NSInteger              goodNum;
@property (nonatomic , copy) NSString              * fmId;
@property (nonatomic , copy) NSString              * fmStatus;
@property (nonatomic , copy) NSString              * fmPrice;
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , assign) BOOL              isGood;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * fmProfile;
@property (nonatomic , copy) NSString              * createExp;
@property (nonatomic , copy) NSString              * audioUrl;
@property (nonatomic , assign) NSInteger              readNum;
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , copy) NSString              * favoriteTime;
@end
