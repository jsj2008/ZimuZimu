//
//  VideoDetailModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetailModel :NSObject
@property (nonatomic , copy) NSString              * videoUrl;              //视频URL
@property (nonatomic , assign) CGFloat              videoPrice;             //视频价格
@property (nonatomic , copy) NSString              * videoTitle;            //视频标题
@property (nonatomic , assign) NSInteger              readNum;              //播放数
@property (nonatomic , assign) NSInteger              goodNum;              //点赞数
@property (nonatomic , copy) NSString              * videoId;               //视频ID
@property (nonatomic , copy) NSString              * videoImg;              //视频封面图片
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * videoLength;           //视频时长
@property (nonatomic , copy) NSString              * videoProfile;          //视频介绍
@property (nonatomic , assign) NSInteger              isOnline;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * userName;              //专家姓名
@property (nonatomic , copy) NSString              * directoryId;
@property (nonatomic , copy) NSString              * expertId;              //专家ID
@property (nonatomic , copy) NSString              * categoryId;

@end
