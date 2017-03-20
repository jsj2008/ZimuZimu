//
//  ZM_MineTableView.m
//  Zimu
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_MineTableView.h"
#import "MineNormalCell.h"
#import "MineMainFunctionCollectionView.h"
#import "MineHeadCell.h"

static NSString *mineHeadCellId = @"ZM_MineheadCellid";
static NSString *mineNormalCellId = @"MineNormalCellid";

#define MINE_HEADCELL_HEIGHT 193
#define MINE_MAINFUN_HEIGHT 95
#define MINE_LISTCELL_HEIGHT 57

@interface ZM_MineTableView ()<UITableViewDelegate, UITableViewDataSource>

/** 中间三个大功能按钮 **/
@property (nonatomic, strong)MineMainFunctionCollectionView *mainFunView;
/** 图片和标题数组 **/
@property (nonatomic, copy) NSArray *imgDataArray;
@property (nonatomic, copy) NSArray *textDataArray;

@end

@implementation ZM_MineTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //设置列表各个单元格的图标和文字数组
        _imgDataArray = @[@[@"mine_orderMananger", @"mine_mycollection", @"mine_previous", @"mine_library"],
                          @[@"mine_feedBack", @"mine_sysConfig"]
                          ];
        _textDataArray = @[@[@"订单管理", @"我的收藏", @"最近浏览", @"我的书架"],
                           @[@"反馈帮组中心", @"设置"]
                           ];
        //注册单元格
        UINib *nib0 = [UINib nibWithNibName:@"MineHeadCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib0 forCellReuseIdentifier:mineHeadCellId];
        
        UINib *nib1 = [UINib nibWithNibName:@"MineNormalCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellReuseIdentifier:mineNormalCellId];
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myNor"];
        
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 4;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return MINE_HEADCELL_HEIGHT;
        }else{
            return MINE_MAINFUN_HEIGHT;
        }
    }else{
        return MINE_LISTCELL_HEIGHT;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if (section == 1){
        return 10;
    }else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MineHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:mineHeadCellId];
            cell.nameLabel.text = @"ffff";
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myNor"];
            if (!_mainFunView) {
                UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
                flowLayout.minimumLineSpacing = 0;
                flowLayout.minimumInteritemSpacing = 0;
                flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
                
                _mainFunView = [[MineMainFunctionCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MINE_MAINFUN_HEIGHT) collectionViewLayout:flowLayout];
            }
            [cell addSubview:_mainFunView];
            return cell;
        }
    }else{
        MineNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:mineNormalCellId];
        cell.markImgView.image = [UIImage imageNamed:_imgDataArray[indexPath.section - 1][indexPath.row]];
        cell.titleLbel.text =_textDataArray[indexPath.section - 1][indexPath.row];
        return cell;
    }
}
@end
