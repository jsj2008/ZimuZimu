//
//  PLMediaViewerPKViewController.m
//  PLMediaStreamingKitDemo
//
//  Created by suntongmian on 16/8/28.
//  Copyright © 2016年 Pili. All rights reserved.
//

#import "PLMediaViewerPKViewController.h"
#import "PLMediaStreamingKit.h"
#import "PLPlayerKit.h"
#import "PLPixelBufferProcessor.h"

#import <GLKit/GLKit.h>
#import <FUAPIDemoBar/FUAPIDemoBar.h>
#import "PhotoButton.h"

#import "FURenderer.h"
#include <sys/mman.h>
#include <sys/stat.h>
#import "authpack.h"

const static char *rtcStateNames[] = {
    "Unknown",
    "ConferenceStarted",
    "ConferenceStopped"
};

const static NSString *playerStatusNames[] = {
    @"PLPlayerStatusUnknow",
    @"PLPlayerStatusPreparing",
    @"PLPlayerStatusReady",
    @"PLPlayerStatusCaching",
    @"PLPlayerStatusPlaying",
    @"PLPlayerStatusPaused",
    @"PLPlayerStatusStopped",
    @"PLPlayerStatusError"
};

@interface PLMediaViewerPKViewController ()<PLMediaStreamingSessionDelegate, PLPlayerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>{
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

@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *conferenceButton;
@property (nonatomic, strong) UIButton *changeCameraStateButton; // 切换前置／后置摄像头

@property (nonatomic, strong) PLMediaStreamingSession *session;
@property (nonatomic, strong) PLPlayer *player;

@property (nonatomic, assign) NSUInteger viewSpaceMask;

@property (nonatomic, strong) NSMutableDictionary *userViewDictionary;
@property (nonatomic, strong) NSString *    userID;
@property (nonatomic, strong) NSString *    roomToken;

@property (nonatomic, assign) NSInteger reconnectCount;

@property (nonatomic, strong) PLPixelBufferProcessor *pixelBufferProcessor;


//添加好友进入语音按钮
@property (nonatomic, strong) UIButton *addCustomerBtn;

@end

@implementation PLMediaViewerPKViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.userViewDictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
    self.reconnectCount = 0;
    
    if (!self.roomName) {
        [self showAlertWithMessage:@"请先在设置界面设置您的房间名" completion:nil];
        return;
    }
    
    [self setupUI];
    [self initStreamingSession];
    [self initPlayer];
    [self startConnect];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleApplicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches allObjects].firstObject;
    if (touch.view != self.view) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.demoBar.transform = CGAffineTransformIdentity;
        self.demoBar.alpha = 0;
    } completion:^(BOOL finished) {
        self.barBtn.hidden = NO;
    }];
}
- (void)setupUI
{
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    
//    self.conferenceButton = [[UIButton alloc] initWithFrame:CGRectMake(196, 90, 66, 66)];
//    [self.conferenceButton setTitle:@"连麦" forState:UIControlStateNormal];
//    [self.conferenceButton setTitle:@"停止" forState:UIControlStateSelected];
//    [self.conferenceButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.conferenceButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [self.conferenceButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.conferenceButton addTarget:self action:@selector(conferenceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.conferenceButton];
//    self.conferenceButton.hidden = YES;
//
//    self.changeCameraStateButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 20, 120, 44)];
//    [self.changeCameraStateButton setTitle:@"切换摄像头" forState:UIControlStateNormal];
//    [self.changeCameraStateButton addTarget:self action:@selector(changeCameraStateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.changeCameraStateButton.hidden = YES;
//    [self.view addSubview:self.changeCameraStateButton];
    [self.view addSubview:self.addCustomerBtn];
    [self.view addSubview:self.demoBar];
    [self.view addSubview:self.barBtn];
}
- (UIButton *)addCustomerBtn{
    if (!_addCustomerBtn) {
        _addCustomerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCustomerBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGFloat width = screenSize.width / 2 - 1;
        CGFloat height = screenSize.height / 2 - 1;
        _addCustomerBtn.frame = CGRectMake((self.viewSpaceMask + 1) % 2 * width, (self.viewSpaceMask + 1) / 2 * height, width, height);
    }
    return _addCustomerBtn;
}
- (FUAPIDemoBar *)demoBar{
    if (!_demoBar) {
        _demoBar = [[FUAPIDemoBar alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 128)];
        _demoBar.itemsDataSource = @[@"noitem", @"tiara", @"item0208", @"YellowEar", @"PrincessCrown", @"Mood" , @"Deer" , @"BeagleDog", @"item0501", @"item0210",  @"HappyRabbi", @"item0204", @"hartshorn", @"heart"];
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


#pragma mark - 推流设置
- (void)initStreamingSession
{
    //屏幕尺寸
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width / 2 - 1;
    CGFloat height = screenSize.height / 2 - 1;
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
    
//    self.actionButton.hidden = NO;
//    self.conferenceButton.hidden = NO;
    
    self.conferenceButton.hidden = NO;

//    #您需要通过 App 的业务服务器去获取连麦需要的 userID 和 roomToken，此处为了 Demo 演示方便，可以在获取后直接设置下面这两个属性
    //0  uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:f-06XvAhikGL4SpgBSKjWHmTTAk=:eyJyb29tX25hbWUiOiJ0ZXN0IiwidXNlcl9pZCI6IjAiLCJwZXJtIjoiYWRtaW4iLCJleHBpcmVfYXQiOjE0OTMwOTI1Mjh9
    //1  uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:1C9e_uWj9rXxVSJFHA0pRLnW3bA=:eyJyb29tX25hbWUiOiJ0ZXN0IiwidXNlcl9pZCI6IjEiLCJwZXJtIjoidXNlciIsImV4cGlyZV9hdCI6MTQ5MzA5MjU3MH0=
    //2  uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:bVZM8cikBvmwb-4BI7YYSzSI3Uo=:eyJyb29tX25hbWUiOiJ0ZXN0IiwidXNlcl9pZCI6IjIiLCJwZXJtIjoidXNlciIsImV4cGlyZV9hdCI6MTQ5MzA5MjU5OH0=
    //3  uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:6DTLOq02RDmc8BP6V_r3FW89ork=:eyJyb29tX25hbWUiOiJ0ZXN0IiwidXNlcl9pZCI6IjMiLCJwZXJtIjoidXNlciIsImV4cGlyZV9hdCI6MTQ5MzA5MjYyNH0=
    self.userID = @"1";
    self.roomToken = @"uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:iDSozCsjtbBu1OzYuEvmUdPdIuk=:eyJyb29tX25hbWUiOiJ0ZXN0IiwidXNlcl9pZCI6IjEiLCJwZXJtIjoidXNlciIsImV4cGlyZV9hdCI6MTQ5MzI1NzIzOX0=";
}
#pragma  mark - 播放器
- (void)initPlayer
{
    if (self.userType == PLMediaUserPKTypeViewer) {
        PLPlayerOption *option = [PLPlayerOption defaultOption];
        
//        #您需要通过 App 的业务服务器去获取播放地址，此处为了 Demo 演示方便，可以直接写死播放地址
        self.player = [PLPlayer playerWithURL:[NSURL URLWithString:@"rtmp://pili-live-rtmp.pili.www.zimu365.com/zimut/zimu3651492680905730A"] option:option];
        self.player.delegate = self;
        [self.view addSubview:self.player.playerView];
        [self.view sendSubviewToBack:self.player.playerView];
        [self.player play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮点击事件
- (IBAction)backButtonClick:(id)sender
{
    self.session.delegate = nil;
    [self.session destroy];
    self.session = nil;
    
    self.player.delegate = nil;
    self.player = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)conferenceButtonClick:(id)sender
{
    self.conferenceButton.enabled = NO;
    if (self.userType == PLMediaUserPKTypeSecondChief) {
        if (!self.conferenceButton.selected) {
            [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:[PLRTCConfiguration defaultConfiguration]];
            NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
            self.session.rtcOption = option;
            self.session.rtcMinVideoBitrate= 300 * 1000;
            self.session.rtcMaxVideoBitrate= 800 * 1000;
        } else {
            [self.session stopConference];
        }
        
        return;
    }
    
    if (self.userType == PLMediaUserPKTypeViewer) {
        if (!self.conferenceButton.selected) {
            [self.player pause];
            self.player.playerView.hidden = YES;
            self.changeCameraStateButton.hidden = NO;
            if (!self.session.previewView.superview) {
                [self.view insertSubview:self.session.previewView atIndex:0];
            }
            
            [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:[PLRTCConfiguration defaultConfiguration]];
            NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
            self.session.rtcOption = option;
            self.session.rtcMinVideoBitrate= 300 * 1000;
            self.session.rtcMaxVideoBitrate= 800 * 1000;
        }
        else {
            [self.session stopConference];
            if (self.session.previewView.superview) {
                [self.session.previewView removeFromSuperview];
            }
            self.changeCameraStateButton.hidden = YES;
            self.player.playerView.hidden = NO;
            [self.player play];
        }
        
        return;
    }
}

// 切换前置／后置摄像头
- (IBAction)changeCameraStateButtonClick:(id)sender {
    [self.session toggleCamera];
}

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
    
    self.player.delegate = nil;
    self.player = nil;
    
    fuDestroyAllItems();
    NSLog(@"PLMediaViewerViewController dealloc");
}
#pragma mark - 开始播放、连麦等事件
//开始连麦
- (void)startConnect{
    [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:[PLRTCConfiguration defaultConfiguration]];
    NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
    self.session.rtcOption = option;
    self.session.rtcMinVideoBitrate= 300 * 1000;
    self.session.rtcMaxVideoBitrate= 540 * 960;
}
//结束连麦
- (void)stopConnect{
    [self.session stopConference];
}

#pragma mark - observer

- (void)handleApplicationDidEnterBackground:(NSNotification *)notification {
    if (!self.session.isRtcRunning) {
        return;
    }
    
    self.conferenceButton.enabled = YES;
    if (self.userType == PLMediaUserPKTypeSecondChief) {
        [self.session stopConference];
        return;
    }
    
    if (self.userType == PLMediaUserPKTypeViewer) {
        [self.session stopConference];
        self.changeCameraStateButton.hidden = YES;
        if (self.session.previewView.superview) {
            [self.session.previewView removeFromSuperview];
        }
        self.player.playerView.hidden = NO;
        [self.player play];
    }
}

#pragma mark - 连麦回调

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session rtcStateDidChange:(PLRTCState)state {
    NSString *log = [NSString stringWithFormat:@"RTC State: %s", rtcStateNames[state]];
    NSLog(@"%@", log);
    
    if (state == PLRTCStateConferenceStarted) {
        self.conferenceButton.enabled = YES;
        self.conferenceButton.selected = YES;
    }
    else {
        self.conferenceButton.enabled = YES;
        self.conferenceButton.selected = NO;
        self.viewSpaceMask = 0;
    }
}

/// @abstract 因产生了某个 error 的回调
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session rtcDidFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    self.conferenceButton.enabled = YES;
    self.conferenceButton.selected = NO;
    [self showAlertWithMessage:[NSString stringWithFormat:@"Error code: %ld, %@", (long)error.code, error.localizedDescription] completion:^{
        [self backButtonClick:nil];
    }];
}

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
    NSInteger row = (self.viewSpaceMask) % 2;
    NSInteger section = (self.viewSpaceMask) / 2;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width / 2 - 1;
    CGFloat height = screenSize.height / 2 - 1;
    
    remoteView.frame = CGRectMake(row * width, section * height, width, height);
    remoteView.clipsToBounds = YES;
    [self.view addSubview:remoteView];
    if (self.viewSpaceMask < 3) {
        _addCustomerBtn.hidden = NO;
        _addCustomerBtn.frame = CGRectMake((self.viewSpaceMask + 1) % 2 * width, (self.viewSpaceMask + 1) / 2 * height, width, height);
    }else{
        _addCustomerBtn.hidden = YES;
    }
    [self.userViewDictionary setObject:remoteView forKey:userID];
    [self.view bringSubviewToFront:self.conferenceButton];
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session userID:(NSString *)userID didDetachRemoteView:(UIView *)remoteView {
    if (![self.userViewDictionary objectForKey:userID]) {
        return;
    }
    [remoteView removeFromSuperview];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width / 2 - 1;
    CGFloat height = screenSize.height / 2 - 1;
    
    
    [self.userViewDictionary removeObjectForKey:userID];
    self.viewSpaceMask --;
    
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

- (CVPixelBufferRef)mediaStreamingSession:(PLMediaStreamingSession *)session cameraSourceDidGetPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    
//    CVPixelBufferRef outputPixelBuffer = [self.pixelBufferProcessor processSourceBuffers:@[[[PLPixelBuffer alloc] initWithCVPixelBuffer:pixelBuffer]]];
//    
//    return outputPixelBuffer;
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

#pragma mark - <PLPlayerDelegate>

- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    NSLog(@"%@", playerStatusNames[state]);
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    NSLog(@"player error: %@", error);
    
    if (self.session.rtcState == PLRTCStateConferenceStarted) {
        return;
    }
    
    self.reconnectCount ++;
    NSString *errorMessage = [NSString stringWithFormat:@"Error code: %ld, %@, 播放器将在%.1f秒后进行第 %ld 次重连", (long)error.code, error.localizedDescription, 0.5 * pow(2, self.reconnectCount - 1), (long)self.reconnectCount];
    [self showAlertWithMessage:errorMessage completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * pow(2, self.reconnectCount) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.player play];
    });
}


#pragma mark - faceUnity 代码

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

@end
