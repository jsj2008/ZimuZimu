//
//  InsertVideoCollectionModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsertCollectionModel :NSObject

@property (nonatomic , copy) NSString              * status;            //状态  0：取消收藏  1：收藏
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * userId;
@property (nonatomic , copy) NSString              * videoId;
@property (nonatomic , copy) NSString              * userVideoId;

@end
