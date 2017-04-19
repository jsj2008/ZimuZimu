//
//  ArticleViewController.h
//  Zimu
//
//  Created by Redpower on 2017/4/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController

@property (nonatomic, copy) NSString *articleTitle;


/*加载网页*/
- (void)loadWebURLSring:(NSString *)string;


@end
