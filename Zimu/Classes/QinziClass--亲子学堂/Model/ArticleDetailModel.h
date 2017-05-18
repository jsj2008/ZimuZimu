//
//  ArticleDetailModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleDetailModel :NSObject

@property (nonatomic , assign) BOOL                  isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , copy) NSString              * object;        //文章ID
@property (nonatomic , copy) NSString              * items;
@property (nonatomic , copy) NSString              * errorCode;

@end
