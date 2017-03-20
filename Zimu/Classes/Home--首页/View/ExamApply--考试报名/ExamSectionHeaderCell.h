//
//  ExamSectionHeaderCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamSectionHeaderCell : UITableViewCell

@property (nonatomic, copy) NSString *imageString;

@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, copy) NSString *buttonImageString;

@property (weak, nonatomic) IBOutlet UIButton *askButton;


@end
