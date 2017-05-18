//
//  FMDetailModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDetailModel :NSObject

@property (nonatomic , copy) NSString              * fmImg;                     //fm图片
@property (nonatomic , copy) NSString              * categoryName;              //
@property (nonatomic , copy) NSString              * fmTitle;                   //fm标题
@property (nonatomic , assign) NSInteger              goodNum;                  //
@property (nonatomic , copy) NSString              * fmId;                      //fmID
@property (nonatomic , copy) NSString              * fmStatus;                  //
@property (nonatomic , copy) NSString              * fmPrice;                   //fm价格
@property (nonatomic , copy) NSString              * keyWord;                   //
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * userName;                  //上传者姓名
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * fmProfile;                 //fm内容
@property (nonatomic , copy) NSString              * createExp;                 //作者id
@property (nonatomic , copy) NSString              * audioUrl;                  //fmURL
@property (nonatomic , assign) NSInteger              readNum;                  //播放次数、热度
@property (nonatomic , copy) NSString              * categoryId;

@end
