//
//  SLDTextCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/3/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLDTextCellLayoutFrame : NSObject

@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect contentLabelFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy) NSString *textString;
@property (nonatomic, copy) NSString *titleString;

- (instancetype)initWithTitle:(NSString *)title TextString:(NSString *)textString;

@end
