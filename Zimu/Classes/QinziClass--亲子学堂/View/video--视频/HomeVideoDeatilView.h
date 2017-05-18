//
//  HomeVideoDeatilView.h
//  Zimu
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoDetailModel.h"
#import "ExpertDetailModel.h"

@interface HomeVideoDeatilView : UITableView

@property (nonatomic, strong) VideoDetailModel *videoDetailModel;
@property (nonatomic, strong) ExpertDetailModel *expertDetailModel;
@property (nonatomic, strong) NSArray *hotVideoModelArray;
@property (nonatomic, strong) NSArray *videoCommentModelArray;

@end
