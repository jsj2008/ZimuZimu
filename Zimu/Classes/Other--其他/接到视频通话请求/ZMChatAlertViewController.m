//
//  ZMChatAlertViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZMChatAlertViewController.h"
#import "ChatRoomMemberView.h"
#import "ZM_CallingHandleCategory.h"

@interface ZMChatAlertViewController ()
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
//聊天室成员
@property (strong, nonatomic) IBOutlet ChatRoomMemberView *chatRoomMemberView;
//拒绝
@property (weak, nonatomic) IBOutlet UIButton *confuseBtn;
//接受
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
//邀请加入语音的文字
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ZMChatAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    NSLog(@"%@ \n %li", _roomName, _isGroup);
    // Do any additional setup after loading the view from its nib.
}

- (void)setUI{
    if (!_chatRoomMemberView) {
        _chatRoomMemberView = [[ChatRoomMemberView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _chatRoomMemberView.backgroundColor = [UIColor clearColor];
        NSArray *array = @[@1, @1, @1];

        CGFloat roomWidth = (kScreenWidth - 120) / 3 * array.count + (array.count - 1) * 30;
        if (array.count <= 2) {
            roomWidth = (kScreenWidth - 120) / 3 * array.count + (array.count) * 30;
        }
        _chatRoomMemberView.frame = CGRectMake(kScreenWidth / 2 - roomWidth / 2, 200, roomWidth, (kScreenWidth - 90) / 3 + 30);
        
        _chatRoomMemberView.dataArray = array;
        _chatRoomMemberView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_chatRoomMemberView];
    }
    
    _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_chatRoomMemberView.frame) + 10, kScreenWidth, 30);
    _textLabel.textAlignment =NSTextAlignmentCenter;
    
    _confuseBtn.layer.cornerRadius = 32.5;
    _confuseBtn.layer.masksToBounds = YES;
    
    _joinBtn.layer.cornerRadius = 32.5;
    _joinBtn.layer.masksToBounds = YES;
    
    _bgImgView.backgroundColor = [UIColor colorWithHexString:@"111111"];
    _bgImgView.alpha = 0.8;

}
#pragma mark - 按钮响应事件
- (IBAction)confuseBtnActiom:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"拒绝");
}
- (IBAction)acceptBtnAction:(id)sender {
    NSLog(@"接受");
    [self dismissViewControllerAnimated:NO completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ZM_CallingHandleCategory *handleJump = [ZM_CallingHandleCategory shareInstance];
//        handleJump.role = ZMChatRoleGroupViewers;
        [handleJump startChat];
//        [handleJump jumpToChatRoom];
    });
    
}


#pragma mark - 网络请求

@end
