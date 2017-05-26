//
//  VideoCommentModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel :NSObject

@property (nonatomic , copy) NSString              * commentVal;        //评论内容
@property (nonatomic , copy) NSString              * userImg;           //用户头像
@property (nonatomic , copy) NSString              * userName;          //用户姓名

@end
