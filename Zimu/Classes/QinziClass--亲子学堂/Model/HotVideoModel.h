//
//  GetHotVideoModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotVideoModel :NSObject

@property (nonatomic , copy) NSString              * categoryId;        //类别ID
@property (nonatomic , copy) NSString              * categoryName;      //类别名称
@property (nonatomic , copy) NSString              * videoPrice;
@property (nonatomic , copy) NSString              * goodNum;
@property (nonatomic , copy) NSString              * videoTitle;        //视频标题
@property (nonatomic , copy) NSString              * videoId;           //视频ID
@property (nonatomic , copy) NSString              * videoImg;          //视频封面图
@property (nonatomic , copy) NSString              * videoLength;       //视频长度
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * videoUrl;          //视频链接
@property (nonatomic , copy) NSString              * isOnline;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * videoProfile;
@property (nonatomic , copy) NSString              * directoryId;
@property (nonatomic , copy) NSString              * expertId;
@property (nonatomic , copy) NSString              * readNum;

@end
