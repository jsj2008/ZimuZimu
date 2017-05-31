//
//  SecretModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecretModel :NSObject

@property (nonatomic , copy) NSString              * questionTitle;         //问题标题
@property (nonatomic , copy) NSString              * questionVal;           //问题内容
@property (nonatomic , copy) NSString              * createTime;            //上传时间
@property (nonatomic , copy) NSString              * careNum;               //关注数
@property (nonatomic , copy) NSString              * count;                 //评论数
@property (nonatomic , copy) NSString              * questionId;            //问题ID
@property (nonatomic , copy) NSString              * isExpAnswer;           //是否已专家解答
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * userId;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * commentList;
@property (nonatomic , copy) NSString              * readNum;
@property (nonatomic , copy) NSString              * categoryId;

@end
