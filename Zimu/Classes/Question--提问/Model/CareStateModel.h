//
//  CareStateModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CareStateModel :NSObject
@property (nonatomic , copy) NSString              * status;            //关注状态  0:未关注  1:已关注
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * questionId;
@property (nonatomic , copy) NSString              * userQuestionId;
@property (nonatomic , copy) NSString              * userId;

@end
