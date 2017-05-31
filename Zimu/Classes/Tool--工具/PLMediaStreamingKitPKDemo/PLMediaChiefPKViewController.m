//
//  PLMediaChiefPKViewController.m
//  PLMediaStreamingKitDemo
//
//  Created by suntongmian on 16/8/28.
//  Copyright © 2016年 Pili. All rights reserved.
//

#import "PLMediaChiefPKViewController.h"
#import "PLMediaStreamingKit.h"
#import "PLPlayerKit.h"
#import "PLPixelBufferProcessor.h"
#import "ZM_CallingHandleCategory.h"

#import <GLKit/GLKit.h>
#import "FUAPIDemoBar.h"
#import "PhotoButton.h"

#import "FURenderer.h"
#include <sys/mman.h>
#include <sys/stat.h>
#import "authpack.h"

const static char *streamStateNames[] = {
    "Unknow",
    "Connecting",
    "Connected",
    "Disconnecting",
    "Disconnected",
    "Error"
};

const static char *rtcStateNames[] = {
    "Unknown",
    "ConferenceStarted",
    "ConferenceStopped"
};

@interface PLMediaChiefPKViewController ()<PLMediaStreamingSessionDelegate, PLPlayerDelegate, FUAPIDemoBarDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>{
    //MARK: Faceunity
    EAGLContext *mcontext;
    int items[3];
    BOOL fuInit;
    int frameID;
    BOOL needReloadItem;
}

//faceUnity需要的变量
@property (strong, nonatomic) FUAPIDemoBar *demoBar;//选择道具工具条
@property (strong, nonatomic) UIButton *barBtn;     //唤起工具条的按钮
@property (nonatomic, strong) AVSampleBufferDisplayLayer *bufferDisplayer;  //显示在界面上的buffer，摄像头显示的内容

//主播界面的一些按钮
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *muteButton;
@property (nonatomic, strong) UIButton *conferenceButton;
@property (nonatomic, strong) UIButton *changeCameraStateButton; // 切换前置／后置摄像头
//推流器
@property (nonatomic, strong) PLMediaStreamingSession *session;
@property (nonatomic, strong) PLPixelBufferProcessor *pixelBufferProcessor;
//当前连麦人数
@property (nonatomic, assign) NSUInteger viewSpaceMask;
//当前连麦的人的字典
@property (nonatomic, strong) NSMutableDictionary *userViewDictionary;
@property (nonatomic, strong) NSString *    userID;
@property (nonatomic, strong) PLStream *stream;

//添加好友进入语音按钮
@property (nonatomic, strong) UIButton *addCustomerBtn;
@property (nonatomic, assign) BOOL isConnect;

@end

@implementation PLMediaChiefPKViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _isConnect = NO;
    self.view.backgroundColor = themeBlack;
    
    [self.navigationController setNavigationBarHidden:YES];
    self.userViewDictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
    
//    if (!self.roomName) {
//        [self showAlertWithMessage:@"请先在设置界面设置您的房间名" completion:nil];
//        return;
//    }
    
    [self setupUI];
    [self initStreamingSession];
//    [self startPush];
    [self startConnect];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleApplicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches allObjects].firstObject;
//    if (touch.view != self.view) {
//        return;
//    }
//    [UIView animateWithDuration:0.5 animations:^{
//        self.demoBar.transform = CGAffineTransformIdentity;
//        self.demoBar.alpha = 0;
//    } completion:^(BOOL finished) {
//        self.barBtn.hidden = NO;
//    }];
}
- (void)setupUI
{
    CGFloat width = self.view.width;
    CGFloat height = self.view.height;
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(width / 2 - 30, height - 65, 60, 60)];
    //    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"phone_confuse"] forState:UIControlStateNormal];
    self.backButton.backgroundColor = [UIColor redColor];
    self.backButton.layer.cornerRadius = 30;
    self.backButton.layer.masksToBounds = YES;
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
//    self.actionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, 66, 66)];
//    [self.actionButton setTitle:@"推流" forState:UIControlStateNormal];
//    [self.actionButton setTitle:@"暂停" forState:UIControlStateSelected];
//    [self.actionButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [self.actionButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.actionButton];
//    self.actionButton.hidden = YES;
//    
//    self.muteButton = [[UIButton alloc] initWithFrame:CGRectMake(116, 90, 66, 66)];
//    [self.muteButton setTitle:@"静音" forState:UIControlStateNormal];
//    [self.muteButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.muteButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    [self.muteButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.muteButton addTarget:self action:@selector(muteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.muteButton];
//    
//    self.conferenceButton = [[UIButton alloc] initWithFrame:CGRectMake(196, 90, 66, 66)];
//    [self.conferenceButton setTitle:@"连麦" forState:UIControlStateNormal];
//    [self.conferenceButton setTitle:@"停止" forState:UIControlStateSelected];
//    [self.conferenceButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.conferenceButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [self.conferenceButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.conferenceButton addTarget:self action:@selector(conferenceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.conferenceButton];
//    self.conferenceButton.hidden = YES;
    
    [self.view addSubview:self.addCustomerBtn];
    [self.view addSubview:self.demoBar];
//    [self.view addSubview:self.barBtn];
//    self.changeCameraStateButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 20, 120, 44)];
//    [self.changeCameraStateButton setTitle:@"切换摄像头" forState:UIControlStateNormal];
//    [self.changeCameraStateButton addTarget:self action:@selector(changeCameraStateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.changeCameraStateButton];
}

- (UIButton *)addCustomerBtn{
    if (!_addCustomerBtn) {
        _addCustomerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCustomerBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        if (self.viewSpaceMask < 3) {
            _addCustomerBtn.hidden = NO;
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            CGFloat width = screenSize.width / 2 - 1;
            CGFloat height = screenSize.height / 2 - 1;
            _addCustomerBtn.frame = CGRectMake((self.viewSpaceMask + 1) % 2 * width, (self.viewSpaceMask + 1) / 2 * height, width, height);
        }else{
            _addCustomerBtn.hidden = YES;
        }
    }
    return _addCustomerBtn;
}
- (FUAPIDemoBar *)demoBar{
    if (!_demoBar) {
        _demoBar = [[FUAPIDemoBar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 198, kScreenWidth, 128)];
        _demoBar.itemsDataSource = FaceUnityItems;// @[@"noitem", @"tiara", @"item0208", @"YellowEar", @"PrincessCrown", @"Mood" , @"Deer" , @"BeagleDog", @"item0501", @"item0210",  @"HappyRabbi", @"item0204", @"hartshorn", @"tiantianquan", @"mao", @"xiong", @"yuhangyuan", @"zhnagyu", @"memeda", @"milu", @"pangxie", @"tuzi", @"xihuanxiong", @"bxgz", @"hunsha", @"wangzi"];
        _demoBar.selectedItem = _demoBar.itemsDataSource[1];
        
        _demoBar.filtersDataSource = @[@"nature", @"delta", @"electric", @"slowlived", @"tokyo", @"warm"];
        _demoBar.selectedFilter = _demoBar.filtersDataSource[0];
        //    _demoBar.backgroundColor = [UIColor clearColor];
        _demoBar.selectedBlur = 6;
        
        _demoBar.beautyLevel = 0.5;
        
        _demoBar.thinningLevel = 1.0;
        
        _demoBar.enlargingLevel = 1.0;
        
        _demoBar.delegate = self;
    }
    return _demoBar;
//    return nil;
}
- (UIButton *)barBtn{
    if (!_barBtn) {
        _barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_barBtn setImage:[UIImage imageNamed:@"camera_btn_filter_normal"] forState:UIControlStateNormal];
        _barBtn.frame = CGRectMake(kScreenWidth - 65, kScreenHeight - 65, 55, 55);
        [_barBtn addTarget:self action:@selector(filterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _barBtn;
}
- (void)filterBtnClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.demoBar.transform = CGAffineTransformMakeTranslation(0, -self.demoBar.frame.size.height);//- (kScreenHeight - self.photoBtn.frame.origin.y));
        self.demoBar.alpha = 1;
//        self.photoBtn.alpha = 0;
    } completion:^(BOOL finished) {
        self.barBtn.hidden = YES;
//        self.photoBtn.hidden = YES;
    }];
    
}
#pragma mark - FUAPIDemoBarDelegate
- (void)demoBarDidSelectedItem:(NSString *)item
{
//    dispatch_async(, ^{
        needReloadItem = YES;
//    });
}
#pragma mark - 初始化摄像头
- (void)initStreamingSession
{
    //屏幕尺寸
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width / 2 - 1;
    CGFloat height = screenSize.height / 2 - 100;
    // 此处初始化一个 PLPixelBufferProcessor 对象用于对回调的视频进行裁剪
    PLVideoCompositionDescription *desc1 = [[PLVideoCompositionDescription alloc] initWithSourceRect:CGRectMake(0, 0, width, height) destRect:CGRectMake(0, 0, width, height ) zOrder:0 aspectMode:PLPixelAspectModeFit];

    self.pixelBufferProcessor = [[PLPixelBufferProcessor alloc] initWithDestFrameSize:CGSizeMake(width, height) videoCompositionDescriptions:@[desc1]];
    
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [[PLVideoStreamingConfiguration alloc] initWithVideoSize:CGSizeMake(width, height) expectedSourceVideoFrameRate:24 videoMaxKeyframeInterval:72 averageVideoBitRate:960 * 540 videoProfileLevel:AVVideoProfileLevelH264HighAutoLevel videoEncoderType:PLH264EncoderType_VideoToolbox];
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    videoCaptureConfiguration.sessionPreset = AVCaptureSessionPreset640x480;
    videoCaptureConfiguration.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    // 请保证 previewMirrorFrontFacing 与 streamMirrorFrontFacing 一致，previewMirrorRearFacing 与 streamMirrorRearFacing 来保证主播预览和推流的效果相同
//    videoCaptureConfiguration.previewMirrorFrontFacing = YES;
//    videoCaptureConfiguration.streamMirrorFrontFacing = YES;
    
    videoCaptureConfiguration.previewMirrorRearFacing = NO;
    videoCaptureConfiguration.streamMirrorRearFacing = NO;
    
    self.session = [[PLMediaStreamingSession alloc]
                    initWithVideoCaptureConfiguration:videoCaptureConfiguration
                    audioCaptureConfiguration:[PLAudioCaptureConfiguration defaultConfiguration]
                    videoStreamingConfiguration:videoStreamingConfiguration
                    audioStreamingConfiguration:[PLAudioStreamingConfiguration defaultConfiguration]
                    stream:nil];
    self.session.delegate = self;
    self.session.captureDevicePosition = videoCaptureConfiguration.position;
    self.session.fillMode = PLVideoFillModePreserveAspectRatioAndFill;
    
    [self.session setBeautifyModeOn:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.session.previewView.frame = CGRectMake(0 , 0, width, height);
        [self.view insertSubview:self.session.previewView atIndex:0];
    });
    
    self.actionButton.hidden = NO;
    self.conferenceButton.hidden = NO;
    
    self.userID = userToken;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClick:(id)sender
{
    [self.session.previewView removeFromSuperview];
    
    self.session.delegate = nil;
    [self.session destroy];
    self.session = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark - 推流按钮点击
- (IBAction)actionButtonClick:(id)sender
{
    [self startPush];
}
- (void)startPush{
    if (!self.session.isStreamingRunning) {
        self.actionButton.enabled = NO;
        if (!self.session.stream) {
            self.session.stream = self.stream;
        }
        
        //        #您需要通过 App 的业务服务器去获取推流地址，此处为了 Demo 演示方便，可以直接写死推流地址
        [self.session startStreamingWithPushURL:[NSURL URLWithString:@"rtmp://pili-publish.pili.www.zimu365.com/zimut/zimu3651492680905730A?e=1493005595751&token=uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:w_5JJoGC8ppQKGc3YrpX2dqfA-k="] feedback:^(PLStreamStartStateFeedback feedback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.actionButton.enabled = YES;
                if (feedback == PLStreamStartStateSuccess) {
                    self.actionButton.selected = YES;
                }
                else {
//                    [self showAlertWithMessage:[NSString stringWithFormat:@"推流失败! feedback is %lu", (unsigned long)feedback] completion:nil];
                    [self showAlertWithMessage:@"通话失败" completion:nil];
                }
            });
        }];
    } else {
        [self.session stopStreaming];
        self.actionButton.selected = NO;
    }

}
#pragma mark - 静音
- (IBAction)muteButtonClick:(id)sender
{
    self.muteButton.selected = !self.muteButton.selected;
    self.session.muted = self.muteButton.selected;
}

#pragma mark - 踢出房间
- (void)kickoutButtonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    UIView *view = button.superview;
    for (NSString *userID in self.userViewDictionary.allKeys) {
        if ([self.userViewDictionary objectForKey:userID] == view) {
            [self.session kickoutUserID:userID];
            break;
        }
    }
}
#pragma mark - 连麦
- (IBAction)conferenceButtonClick:(id)sender
{
    self.conferenceButton.enabled = NO;
    if (!self.conferenceButton.selected) {
        [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:[PLRTCConfiguration defaultConfiguration]];
        NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
        self.session.rtcOption = option;
        self.session.rtcMinVideoBitrate= 300 * 1000;
        self.session.rtcMaxVideoBitrate= 800 * 1000;
        
        // 连麦的画面在主画面中的位置和大小
        self.session.rtcMixOverlayRectArray = [NSArray arrayWithObjects:[NSValue valueWithCGRect:CGRectMake(320, 0, 320, 360)], nil];
    }
    else {
        [self.session stopConference];
    }
    return;
}
//开始连麦
- (void)startConnect{
    if (!_isConnect) {
        _isConnect = YES;
        [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:[PLRTCConfiguration defaultConfiguration]];
        NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
        self.session.rtcOption = option;
        self.session.rtcMinVideoBitrate= 300 * 1000;
        self.session.rtcMaxVideoBitrate= 540 * 960;
    }
}
//结束连麦
- (void)stopConnect{
    _isConnect = NO;
    [self.session stopConference];
}

// 切换前置／后置摄像头
- (void)changeCameraStateButtonClick:(id)sender {
    [self.session toggleCamera];
}
#pragma mark - 显示提示栏
- (void)showAlertWithMessage:(NSString *)message completion:(void (^)(void))completion
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"错误" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)dealloc
{
    self.session.delegate = nil;
    [self.session destroy];
    self.session = nil;
    
    fuDestroyAllItems();
    
    ZM_CallingHandleCategory *call = [ZM_CallingHandleCategory shareInstance];
    [call leaveChatRoome];
    NSLog(@"PLMediaChiefViewController dealloc");
}
#pragma mark -
- (void)requestStreamJsonWithCompleted:(void (^)(NSDictionary *json))handler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://pili-demo.qiniu.com/api/stream/%@", self.roomName]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil || response == nil || data == nil) {
            NSLog(@"get streamjson faild, %@, %@, %@", error, response, data);
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil);
            });
            return;
        }
        
        NSDictionary *streamJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (error != nil || streamJSON == nil) {
            NSLog(@"json decode error %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(streamJSON);
        });
        
    }];
    [task resume];
}

- (void)requestTokenWithUserID:(NSString *)userID completed:(void (^)(NSString *token))handler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://pili-demo.qiniu.com/api/room/%@/user/%@/token", self.roomName, userID]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil || response == nil || data == nil) {
            NSLog(@"get token faild, %@, %@, %@", error, response, data);
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil);
            });
            return;
        }
        
        NSString *token = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(token);
        });
    }];
    [task resume];
}

#pragma mark - observer

- (void)handleApplicationDidEnterBackground:(NSNotification *)notification {
    if (self.session.isRtcRunning) {
        [self.session stopConference];
        self.conferenceButton.enabled = YES;
    }
}

#pragma mark - 推流回调

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session streamStateDidChange:(PLStreamState)state {
    NSString *log = [NSString stringWithFormat:@"Stream State: %s", streamStateNames[state]];
    NSLog(@"%@", log);
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didDisconnectWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    self.actionButton.enabled = YES;
//    [self showAlertWithMessage:[NSString stringWithFormat:@"Error code: %ld, %@", (long)error.code, error.localizedDescription] completion:nil];
    [self showAlertWithMessage:@"通话中断" completion:nil];
}


/// @abstract 当开始推流时，会每间隔 3s 调用该回调方法来反馈该 3s 内的流状态，包括视频帧率、音频帧率、音视频总码率
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session streamStatusDidUpdate:(PLStreamStatus *)status {
    [self startConnect];
    NSLog(@"%@", status);
}

#pragma mark - 连麦回调

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session rtcStateDidChange:(PLRTCState)state {
    NSString *log = [NSString stringWithFormat:@"RTC State: %s", rtcStateNames[state]];
    NSLog(@"%@", log);
    
    if (state == PLRTCStateConferenceStarted) {
        self.conferenceButton.selected = YES;
        _isConnect = YES;
    } else {
        self.conferenceButton.selected = NO;
        self.viewSpaceMask = 0;
    }
    self.conferenceButton.enabled = YES;
}

/// @abstract 因产生了某个 error 的回调
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session rtcDidFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    self.conferenceButton.enabled = YES;
//    [self showAlertWithMessage:[NSString stringWithFormat:@"Error code: %ld, %@", (long)error.code, error.localizedDescription] completion:^{
//        [self backButtonClick:nil];
//    }];
    [self showAlertWithMessage:@"连接断开" completion:^{
        
    }];
}
#pragma mark - 连麦观众界面设置
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session userID:(NSString *)userID didAttachRemoteView:(UIView *)remoteView {
    //只允许三个连麦观众
    //加上主播一共四个
    if (self.viewSpaceMask != 3) {
        self.viewSpaceMask ++;
    } else {
        //超出 3 个连麦观众，不再显示。
        return;
    }
    //row     : 当前remoteView所在的行
    //section : 当前remoteView所在列
    //width   : 当前remoteView的宽度
    //height  : 当前remoteView的高度
    NSInteger row = (self.viewSpaceMask ) % 2;
    NSInteger section = (self.viewSpaceMask ) / 2;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width / 2 - 1;
    CGFloat height = screenSize.height / 2 - 100;
    
    remoteView.frame = CGRectMake(row * width, section * height, width, height);
    remoteView.clipsToBounds = YES;
    [self.view addSubview:remoteView];
    if (self.viewSpaceMask < 3) {
        _addCustomerBtn.hidden = NO;
        _addCustomerBtn.frame = CGRectMake((self.viewSpaceMask + 1) % 2 * width, (self.viewSpaceMask + 1) / 2 * height, width, height);
    }else{
        _addCustomerBtn.hidden = YES;
    }
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width * 0.4 - 40, 0, 40, 20)];
//    [button setTitle:@"踢出" forState:UIControlStateNormal];
//    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [button addTarget:self action:@selector(kickoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [remoteView addSubview:button];
    
    [self.userViewDictionary setObject:remoteView forKey:userID];
    [self.view bringSubviewToFront:self.conferenceButton];
    
    //设置添加用户按钮的
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session userID:(NSString *)userID didDetachRemoteView:(UIView *)remoteView {
    if (![self.userViewDictionary objectForKey:userID]) {
        return;
    }
    [remoteView removeFromSuperview];
    
    [self.userViewDictionary removeObjectForKey:userID];
    self.viewSpaceMask --;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width / 2 - 1;
    CGFloat height = screenSize.height / 2 - 1;
    
    if (self.viewSpaceMask < 3) {
        _addCustomerBtn.hidden = NO;
        _addCustomerBtn.frame = CGRectMake((self.viewSpaceMask + 1) % 2 * width, (self.viewSpaceMask + 1) / 2 * height, width, height);
    }else{
        _addCustomerBtn.hidden = YES;
    }
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didKickoutByUserID:(NSString *)userID {
    [self showAlertWithMessage:@"您被主播踢出房间了！" completion:^{
        [self backButtonClick:nil];
    }];
}

#pragma mark - faceUnity 代码
- (CVPixelBufferRef)mediaStreamingSession:(PLMediaStreamingSession *)session cameraSourceDidGetPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    
//    CVPixelBufferRef outputPixelBuffer = [self.pixelBufferProcessor processSourceBuffers:@[[[PLPixelBuffer alloc] initWithCVPixelBuffer:pixelBuffer]]];
//    CVPixelBufferRef realBuffer = CMSampleBufferGetImageBuffer(pixelBuffer);
    
    //如果当前环境中已存在EAGLContext，此步骤可省略，但必须要调用[EAGLContext setCurrentContext:curContext]函数。
#warning 此步骤不可放在异步线程中执行
    [self setUpContext];
    
    //Faceunity初始化
#warning 此步骤不可放在异步线程中执行
    if (!fuInit)
    {
        fuInit = YES;
        int size = 0;
        void *v3 = [self mmap_bundle:@"v3.bundle" psize:&size];
        
        [[FURenderer shareRenderer] setupWithData:v3 ardata:NULL authPackage:&g_auth_package authSize:sizeof(g_auth_package)];
    }
    if (needReloadItem) {
        needReloadItem = NO;
        [self reloadItem];
    }
    
    //加载美颜道具
    if (items[1] == 0) {
        [self loadFilter];
    }
    
    //加载爱心道具
    if (items[2] == 0) {
        [self loadHeart];
    }
    
    //设置美颜效果（滤镜、磨皮、美白、瘦脸、大眼....）
    fuItemSetParamd(items[1], "cheek_thinning", self.demoBar.thinningLevel); //瘦脸
    fuItemSetParamd(items[1], "eye_enlarging", self.demoBar.enlargingLevel); //大眼
    fuItemSetParamd(items[1], "color_level", self.demoBar.beautyLevel); //美白
    fuItemSetParams(items[1], "filter_name", (char *)[_demoBar.selectedFilter UTF8String]); //滤镜
    fuItemSetParamd(items[1], "blur_level", self.demoBar.selectedBlur); //磨皮
    CVPixelBufferRef returnBuffer = [[FURenderer shareRenderer] renderPixelBuffer:pixelBuffer withFrameId:frameID items:items itemCount:3];
    frameID += 1;
    
    return returnBuffer;
}
#pragma -Faceunity Set EAGLContext
- (void)setUpContext
{
    if(!mcontext){
        mcontext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    if(!mcontext || ![EAGLContext setCurrentContext:mcontext]){
        NSLog(@"faceunity: failed to create / set a GLES2 context");
    }
    
}

#pragma -Faceunity Load Data
- (void)reloadItem
{
    if (items[0] != 0) {
        NSLog(@"faceunity: destroy item");
        fuDestroyItem(items[0]);
    }
    
    if ([_demoBar.selectedItem isEqual: @"noitem"] || _demoBar.selectedItem == nil)
    {
        items[0] = 0;
        return;
    }
    
    int size = 0;
    
    // load selected
    void *data = [self mmap_bundle:[_demoBar.selectedItem stringByAppendingString:@".bundle"] psize:&size];
    if (!data) {
        data = [self mmap_bundle:[_demoBar.selectedItem stringByAppendingString:@".mp3"] psize:&size];
    }
    items[0] = fuCreateItemFromPackage(data, size);
    
    NSLog(@"faceunity: load item");
}

- (void)loadFilter
{
    int size = 0;
    
    void *data = [self mmap_bundle:@"face_beautification.bundle" psize:&size];
    
    items[1] = fuCreateItemFromPackage(data, size);
}

- (void)loadHeart
{
    int size = 0;
    
    void *data = [self mmap_bundle:@"heart.bundle" psize:&size];
    
    items[2] = fuCreateItemFromPackage(data, size);
}

- (void *)mmap_bundle:(NSString *)bundle psize:(int *)psize {
    
    // Load item from predefined item bundle
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundle];
    const char *fn = [str UTF8String];
    int fd = open(fn,O_RDONLY);
    
    int size = 0;
    void* zip = NULL;
    
    if (fd == -1) {
        NSLog(@"faceunity: failed to open bundle");
        size = 0;
    }else
    {
        size = [self getFileSize:fd];
        zip = mmap(nil, size, PROT_READ, MAP_SHARED, fd, 0);
    }
    
    *psize = size;
    return zip;
}

- (int)getFileSize:(int)fd
{
    struct stat sb;
    sb.st_size = 0;
    fstat(fd, &sb);
    return (int)sb.st_size;
}

#pragma mark -- 限制控制器方向为 右横屏

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    if (UIInterfaceOrientationLandscapeRight == toInterfaceOrientation) {
//        self.session.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
//    } else {
//        self.session.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
//    }
//}

//- (BOOL)shouldAutorotate {
//    return NO;
//}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeRight;
//}

@end
