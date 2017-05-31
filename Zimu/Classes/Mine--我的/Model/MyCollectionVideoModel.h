//
//  MyCollectionVideoModel.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionVideoModel : NSObject
@property (nonatomic , copy) NSString              * videoUrl;
@property (nonatomic , assign) CGFloat              videoPrice;
@property (nonatomic , copy) NSString              * videoTitle;
@property (nonatomic , assign) NSInteger              readNum;
@property (nonatomic , assign) NSInteger              goodNum;
@property (nonatomic , copy) NSString              * videoId;
@property (nonatomic , copy) NSString              * videoImg;
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * videoLength;
@property (nonatomic , copy) NSString              * videoProfile;
@property (nonatomic , copy) NSString              * isOnline;
@property (nonatomic , copy) NSString              * favoriteTime;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * directoryId;
@property (nonatomic , copy) NSString              * expertId;
@property (nonatomic , copy) NSString              * categoryId;
@end
