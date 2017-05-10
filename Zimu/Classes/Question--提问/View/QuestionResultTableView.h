//
//  QuestionResultTableView.h
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionResultTableViewDelegate <NSObject>

- (void)questionResultTableViewDidScroll;

@end

@interface QuestionResultTableView : UITableView

@property (nonatomic, strong) NSMutableArray *resultArray;

@property (nonatomic, assign) id<QuestionResultTableViewDelegate> scrollDelegate;

@end
