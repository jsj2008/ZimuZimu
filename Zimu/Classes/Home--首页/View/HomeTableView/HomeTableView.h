//
//  HomeTableView.h
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannerModel.h"
#import "HomeRecommendTodayModel.h"
#import "HomeFourImageModel.h"
#import "HomeExpertListModel.h"
#import "HomeFreeCourseModel.h"
#import "HomeNotFreeCourseModel.h"
#import "HomeFMModel.h"
#import "HomeArticleModel.h"

@interface HomeTableView : UITableView

@property (nonatomic, strong) HomeBannerModel *homeBannerModel;
@property (nonatomic, strong) HomeRecommendTodayModel *homeRecommendTodayModel;
@property (nonatomic, strong) HomeFourImageModel *homeFourImageModel;
@property (nonatomic, strong) HomeExpertListModel *homeExpertListModel;
@property (nonatomic, strong) HomeFreeCourseModel *homeFreeCourseModel;
@property (nonatomic, strong) HomeNotFreeCourseModel *homeNotFreeCourseModel;
@property (nonatomic, strong) HomeFMModel *homeFMModel;
@property (nonatomic, strong) HomeArticleItems *homeArticleItem;


@property (nonatomic, strong) NSArray *homeBannerArray;
@property (nonatomic, strong) NSArray *homeFourImageArray;
@property (nonatomic, strong) NSArray *homeExpertListArray;
@property (nonatomic, strong) NSArray *homeFreeCourseArray;
@property (nonatomic, strong) NSArray *homeNotFreeCourseArray;
@property (nonatomic, strong) NSArray *homeFMArray;

@end

