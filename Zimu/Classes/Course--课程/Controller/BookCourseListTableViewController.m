//
//  BookCourseListTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookCourseListTableViewController.h"
#import "BookSectionCell.h"
#import "BookRowCell.h"

static NSString *sectionIdentifier = @"BookSectionCell";
static NSString *rowIdentifier = @"BookRowCell";
@interface BookCourseListTableViewController ()

@end

@implementation BookCourseListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithHexString:@"CDCDCD"];
    [self registerCells];
}

- (void)registerCells{
    [self.tableView registerNib:[UINib nibWithNibName:@"BookSectionCell" bundle:nil] forCellReuseIdentifier:sectionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookRowCell" bundle:nil] forCellReuseIdentifier:rowIdentifier];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BookSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 1.0f, 0, 0, 0);
        
        return cell;
    }
    BookRowCell *cell = [tableView dequeueReusableCellWithIdentifier:rowIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(cell.height - 1.0f, 20, 0, 0);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}



@end
