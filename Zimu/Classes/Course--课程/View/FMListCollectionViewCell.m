//
//  FMListCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMListCollectionViewCell.h"
#import "AlignmentLabel.h"

@interface FMListCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *FMImageView;
@property (weak, nonatomic) IBOutlet AlignmentLabel *titleLabel;


@end

@implementation FMListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = titleString;
    }
}

@end
