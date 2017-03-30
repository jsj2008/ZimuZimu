//
//  HomeArticleModel.h
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeArticleItems :NSObject
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * contentUrl;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * articleTitle;
@property (nonatomic , assign) NSInteger              goodNum;
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , copy) NSString              * articleId;
@property (nonatomic , copy) NSString              * articleAbs;
@property (nonatomic , copy) NSString              * articleImg;
@property (nonatomic , assign) NSInteger              readNum;
@property (nonatomic , copy) NSString              * categoryName;

@end

@interface HomeArticleModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<HomeArticleItems *>              * items;

@end
