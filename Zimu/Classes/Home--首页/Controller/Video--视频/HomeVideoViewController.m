//
//  HomeVideoViewController.m
//  Zimu
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeVideoViewController.h"
#import "HomeVideoListCollectionView.h"

@interface HomeVideoViewController ()

@end

@implementation HomeVideoViewController{
    NSDictionary *_testDic;     //接口未发布使用的
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    self.title = @"视频课程";
    _testDic = @{@"cycle":@[@{@"title":@"如何让孩子产生安全感",
                                @"pic":@"cycle_03.jpg"
                                
                              },
                            @{@"title":@"如何让孩子产生安全感",
                                @"pic":@"cycle_03.jpg"
                                  
                                  },
                            @{@"title":@"如何让孩子产生安全感",
                                @"pic":@"cycle_03.jpg"
                                      
                                      }],
                 @"video":@{@"sectionTitle":@"专题课程",
                              @"type":@"1",
                              @"seectionData":@[@{@"videoTitle":@"孩子不爱",
                                                  @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                  @"videoPic":@"cycle_03.jpg"
                                                  },
                                                @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                  @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                  @"videoPic":@"cycle_03.jpg"
                                                  },
                                                @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                  @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                  @"videoPic":@"cycle_03.jpg"
                                                  },
                                                @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                  @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                  @"videoPic":@"cycle_03.jpg"
                                                  }
                                                ]
                              },
                @"videoList":@[@{@"sectionTitle":@"亲子感情",
                                  @"type":@"1",
                                  @"seectionData":@[@{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      },
                                                    @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      },
                                                    @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      },
                                                    @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      }
                                                    ]
                                  },
                                @{@"sectionTitle":@"孩子学习",
                                  @"type":@"1",
                                  @"seectionData":@[@{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      },
                                                    @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      },
                                                    @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      },
                                                    @{@"videoTitle":@"孩子不爱学习是谁的原因",
                                                      @"videoText":@"你以为是谁的原因，今天就让我们去深入研究孩子的心理",
                                                      @"videoPic":@"cycle_03.jpg"
                                                      }
                                                    ]
                                  }
                            ]
                 };
    
    [self makeUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - makeUI
- (void)makeUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    HomeVideoListCollectionView *viedoListView = [[HomeVideoListCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    [viedoListView setCirData:_testDic[@"cycle"] subjectCourseListData:_testDic[@"video"] videoListData:_testDic[@"videoList"]];
    viedoListView.backgroundColor = themeGray;
    [self.view addSubview:viedoListView];
}
@end
