//
//  ExpertTableViewCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tagString1;
@property (nonatomic, copy) NSString *tagString2;
@property (nonatomic, copy) NSString *tagString3;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *countString;
@property (nonatomic, copy) NSString *percentString;

@end
