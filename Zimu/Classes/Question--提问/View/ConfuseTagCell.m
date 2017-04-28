//
//  ConfuseTagCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ConfuseTagCell.h"
#import "TagCollectionView.h"

@interface ConfuseTagCell ()

@property (weak, nonatomic) IBOutlet TagCollectionView *tagcollectionView;


@end

@implementation ConfuseTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _tagcollectionView.userInteractionEnabled = NO;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setTagArray:(NSArray *)tagArray{
    if (_tagArray != tagArray) {
        _tagArray = tagArray;
        _tagcollectionView.tagArray = tagArray;
        [_tagcollectionView reloadData];
    }
}

@end
