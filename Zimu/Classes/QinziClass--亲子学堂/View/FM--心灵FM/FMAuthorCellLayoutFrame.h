//
//  FMAuthorCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpertDetailModel.h"

@interface FMAuthorCellLayoutFrame : NSObject

- (instancetype)initWithExpertDetailModel:(ExpertDetailModel *)expertDetailModel;
@property (nonatomic, strong) ExpertDetailModel *expertDetailModel;

@property (nonatomic, assign) CGRect headImageViewFrame;
@property (nonatomic, assign) CGRect coverImageViewFrame;
@property (nonatomic, assign) CGRect nameLabelFrame;
@property (nonatomic, assign) CGRect introLabelFrame;

@property (nonatomic, assign) CGRect countLabelFrame;
@property (nonatomic, assign) CGRect timeLabelFrame;
@property (nonatomic, assign) CGFloat cellHeight;




@end
