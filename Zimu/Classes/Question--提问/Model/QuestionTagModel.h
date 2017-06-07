//
//  QuestionTagModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QuestionTagModel :NSObject

@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * categoryName;      //标签名
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , copy) NSString              * preCateId;         //标签ID
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * categoryList;

@end
