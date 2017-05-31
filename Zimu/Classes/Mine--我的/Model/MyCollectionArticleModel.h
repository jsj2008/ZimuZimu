//
//  MyCollectionArticleModel.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionArticleModel : NSObject
@property (nonatomic , copy) NSString              * articleId;
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , copy) NSString              * articleImg;
@property (nonatomic , assign) NSInteger              goodNum;
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * articleAbs;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * favoriteTime;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * createExp;
@property (nonatomic , copy) NSString              * articleContent;
@property (nonatomic , copy) NSString              * auditStatus;
@property (nonatomic , copy) NSString              * contentUrl;
@property (nonatomic , copy) NSString              * articleTitle;
@property (nonatomic , assign) NSInteger              readNum;
@end
