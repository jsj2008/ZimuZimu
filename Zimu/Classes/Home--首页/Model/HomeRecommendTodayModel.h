//
//  HomeRecommendTodayModel.h
//  Zimu
//
//  Created by Redpower on 2017/3/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article :NSObject
@property (nonatomic , copy) NSString              * articleTitle;
@property (nonatomic , copy) NSString              * articleId;
@property (nonatomic , copy) NSString              * articleAbs;

@end

@interface Fm :NSObject
@property (nonatomic , copy) NSString              * fmTitle;
@property (nonatomic , copy) NSString              * fmId;

@end

@interface Video :NSObject
@property (nonatomic , copy) NSString              * videoId;
@property (nonatomic , copy) NSString              * videoTitle;
@property (nonatomic , copy) NSString              * videoProfile;

@end

@interface Item :NSObject
@property (nonatomic , strong) Article              * article;
@property (nonatomic , strong) Fm                   * fm;
@property (nonatomic , strong) Video                * video;

@end

@interface HomeRecommendTodayModel :NSObject
@property (nonatomic , assign) BOOL                   isTrue;
@property (nonatomic , copy) NSString               * message;
@property (nonatomic , strong) Item               * object;

@end
