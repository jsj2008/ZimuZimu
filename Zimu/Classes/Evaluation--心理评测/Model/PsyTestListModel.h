//
//  PsyTestListModel.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PsyTestListModel : NSObject
@property (nonatomic , copy) NSString              * testId;
@property (nonatomic , copy) NSString              * testTitle;
@property (nonatomic , copy) NSString              * testUrl;
@property (nonatomic , assign) NSInteger              userNum;
@property (nonatomic , copy) NSString              * createUser;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , copy) NSString              * profile;
@property (nonatomic , copy) NSString              * testImg;
@property (nonatomic , assign) NSInteger              createTime;
@end
