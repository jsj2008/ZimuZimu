//
//  QuestionDetailModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * questionTitle;         //问题标题
@property (nonatomic , copy) NSString              * questionVal;           //问题内容
@property (nonatomic , copy) NSString              * userId;                //专家ID
@property (nonatomic , copy) NSString              * count;                 //评论数量
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , copy) NSString              * categoryName;          //标签
@property (nonatomic , copy) NSString              * careNum;              //关注数
@property (nonatomic , copy) NSString              * questionId;            //问题ID
@property (nonatomic , copy) NSString              * isDel;                //是否专家已解答
@property (nonatomic , copy) NSString              * readNum;              //阅读数
@property (nonatomic , copy) NSString              * createTime;            //问题上传时间

@end

@interface QuestionDetailModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) QuestionModel              * object;

@end
