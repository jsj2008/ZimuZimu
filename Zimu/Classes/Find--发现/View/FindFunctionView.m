//
//  FindFunctionView.m
//  Zimu
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindFunctionView.h"
#import "FindFunctionsCell.h"

#define FIND_FUN_WIDTH (kScreenWidth - 29) / 4
#define FIND_FUN_HEGHT FIND_FUN_WIDTH
static NSString *cellReuesId = @"FindFunctionsCelLId";
@interface FindFunctionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 图片和标题数组 **/
@property (nonatomic, copy) NSArray *imgDataArray;
@property (nonatomic, copy) NSArray *textDataArray;

@end

@implementation FindFunctionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _imgDataArray = @[@"find_ask", @"find_text", @"find_video", @"find_test"];
        _textDataArray = @[@"问答", @"文章", @"书籍", @"测试"];
        
        UINib *nib = [UINib nibWithNibName:@"FindFunctionsCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:cellReuesId];
        
        self.backgroundColor = themeWhite;
        self.delegate =self;
        self.dataSource = self;
    }
    return self;
}


#pragma mark - 代理和数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FindFunctionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuesId forIndexPath:indexPath];
    cell.icon.image = [UIImage imageNamed:_imgDataArray[indexPath.row]];
    cell.name.text = _textDataArray[indexPath.row];
    return cell;
}
#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(FIND_FUN_WIDTH, FIND_FUN_HEGHT);
}
@end
