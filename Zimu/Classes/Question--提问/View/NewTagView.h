//
//  NewTagView.h
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTagView : UIView

@property (nonatomic, copy) NSString *tagText;          //选好的标签
@property (nonatomic, copy) NSString *tagId;            //选好的tagID

@property (nonatomic, strong) NSArray *tagModelArray;


@end
