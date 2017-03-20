//
//  HomeArrayDataSource.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeArrayDataSource.h"
#import "TestViewController.h"
#import "UIView+ViewController.h"
#import "HomeTableViewCell.h"
#import "HeaderTitleCell.h"
#import "VideoCourseCell.h"

static NSString *headerTitleIdentifier = @"headerTitleCell";
static NSString *videoCourseIdentifier = @"videoCourseCell";

@interface HomeArrayDataSource ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *identifier;
//@property (nonatomic, copy) HomeTableViewCellBlock homeTableViewCellBlock;

@end

@implementation HomeArrayDataSource

<<<<<<< HEAD:Zimu/Classes/Home--首页/View/HomeTableView/HomeArrayDataSource.m
- (instancetype)initWithDataArray:(NSArray *)dataArray cellIdentifier:(NSString *)cellIdentifier homeTableViewCellBlock:(HomeTableViewCellBlock)block{
    self = [super init];
    if (self) {
=======


- (instancetype)initWithDataArray:(NSArray *)dataArray cellIdentifier:(NSString *)cellIdentifier homeTableViewCellBlock:(HomeTableViewCellBlock)block{
    self = [super init];
    if (self) {

>>>>>>> origin/master:Zimu/Classes/Home--首页/View/HomeArrayDataSource.m
        
        _titleArray = @[@"热门推荐",@"暖心读物",@"精彩问答",@"完美鸡汤"];

        _dataArray = dataArray;
        _identifier = cellIdentifier;
//        _homeTableViewCellBlock = block;
        
    }
    return self;
}



//UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UINib *nib = [UINib nibWithNibName:@"HeaderTitleCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:headerTitleIdentifier];
    UINib *nib2 = [UINib nibWithNibName:@"VideoCourseCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib2 forCellReuseIdentifier:videoCourseIdentifier];
    
    
    if (indexPath.row == 0) {
        HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
        
        return cell;
    }
    VideoCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCourseIdentifier];
    
    
    
    return cell;
//    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
//    if (cell == nil) {
//        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.homeTableViewCellBlock(cell, self.dataArray[indexPath.row]);
    
}


#pragma mark - <##>


- (UIViewController*)topViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return [self topViewControllerWithRootViewController:window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController1 = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController1.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


@end
