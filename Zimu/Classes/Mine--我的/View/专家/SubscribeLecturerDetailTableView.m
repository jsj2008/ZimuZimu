//
//  SubscribeLecturerDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeLecturerDetailTableView.h"
#import "SLDTextCell.h"
#import "SLDTextCellLayoutFrame.h"

//static NSString *SLDTitleCellIdentifier = @"SLDTitleCell";
static NSString *SLDTextCellIdentifier = @"SLDTextCell";

@interface SubscribeLecturerDetailTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *contents;

@end

@implementation SubscribeLecturerDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = themeGray;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"SLDTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SLDTextCellIdentifier];

        _titles = @[@"相关资质",@"从业背景与经验",@"适宜人群",@"最近更新"];
        _contents = @[@"清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师\n清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师",
                      @"从业经验：2011年参加亲密之旅培训并成为带领者，6年来带领婚恋情商训练20余场，时长超过500小时；2012年参加爱家《无悔今生》培训员训练成为青少年讲师，带领青少年课程、营会超过60场，受益者超过3000人；1013年参加杭州温莎教育心理咨询师系统训练，考取心理咨询师二级；之后陆续参加《绽放孩子的天赋才华》、《行为认知疗法法》、《萨提亚家庭治疗模式》、《P.E.T.父母效能训练》、《NLP心灵成长》、《完形格式塔》、《TA交互式沟通》等培训；整合应用心理学各流派知识技能\n\n培训思路：以全人成长为目标；结合中医“阴平阳秘，精神乃治”、“虚则补之，实则泻之”、“通则不痛，通则不痛”、辨证治疗等理念，综合人本主义、EFT、行为认知疗法、萨提亚家庭式治疗等技巧；帮助人不仅仅关注解决当下产生的问题，更能深入追溯疗愈原生家庭及成长经历中的未完成事件的影响，立足于当下，着眼于未来的全人成长；致力于成为无条件接纳每一个学员、愿意用心倾听和陪伴并用智慧和学员一起成长的心灵导师！",
                      @"1、教育系统（大中学生、教师）\n2、家庭教育（普通家长、孩子）\n3、企业员工训练\n4、心理咨询师、婚姻家庭咨询师",
                      @"塑造孩子的自信"];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLDTextCell *cell = [tableView dequeueReusableCellWithIdentifier:SLDTextCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SLDTextCellLayoutFrame *layout = [[SLDTextCellLayoutFrame alloc]initWithTitle:_titles[indexPath.section] TextString:_contents[indexPath.section]];
    cell.layoutFrame = layout;
    
    return cell;
}




@end
