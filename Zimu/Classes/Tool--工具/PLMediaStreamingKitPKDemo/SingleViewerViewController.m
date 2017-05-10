//
//  SingleViewerViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SingleViewerViewController.h"
#import "PLPlayerKit.h"
#import "PLMediaStreamingKit.h"

#import <GLKit/GLKit.h>
#import "FUAPIDemoBar.h"
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

@interface SingleViewerViewController ()<PLMediaStreamingSessionDelegate, PLPlayerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, FUAPIDemoBarDelegate>{
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
@property (nonatomic, strong) UIButton *toggleButton;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) PLMediaStreamingSession *session;
@property (nonatomic, strong) PLPlayer *player;

@property (nonatomic, assign) NSUInteger viewSpaceMask;

@property (nonatomic, strong) NSMutableDictionary *userViewDictionary;
@property (nonatomic, strong) NSString *    userID;
@property (nonatomic, strong) NSString *    roomToken;

@property (nonatomic, assign) NSInteger reconnectCount;

@property (nonatomic, strong) UIView *fullscreenView;
@property (nonatomic, strong) UIView *tappedView;
@property (nonatomic, assign) CGRect originRect;


@end

@implementation SingleViewerViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES];
    self.userViewDictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
    self.reconnectCount = 0;
//    
//    if (!self.roomName) {
//        [self showAlertWithMessage:@"请先在设置界面设置您的房间名" completion:nil];
//        return;
//    }
    
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
//    UITouch *touch = [touches allObjects].firstObject;
//    if (touch.view != self.view) {
//        return;
//    }
    [UIView animateWithDuration:0.5 animations:^{
        self.demoBar.transform = CGAffineTransformIdentity;
        self.demoBar.alpha = 0;
    } completion:^(BOOL finished) {
        self.barBtn.hidden = NO;
    }];
}
- (void)setupUI
{
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 66, 66)];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
//    self.conferenceButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 66 - 20, size.height - 66, 66, 66)];
//    [self.conferenceButton setTitle:@"连麦" forState:UIControlStateNormal];
//    [self.conferenceButton setTitle:@"停止" forState:UIControlStateSelected];
//    [self.conferenceButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.conferenceButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [self.conferenceButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.conferenceButton addTarget:self action:@selector(conferenceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.conferenceButton];
//    self.conferenceButton.hidden = YES;
//    
//    if (self.audioOnly) {
//        self.view.backgroundColor = [UIColor blackColor];
//        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 106, size.width, size.height - 106 * 2)];
//        self.textView.editable = NO;
//        self.textView.backgroundColor = [UIColor clearColor];
//        self.textView.textColor = [UIColor whiteColor];
//        [self.view addSubview:self.textView];
//    }
//    else {
        self.toggleButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 66 - 20, 20, 66, 66)];
        [self.toggleButton setTitle:@"切换" forState:UIControlStateNormal];
        [self.toggleButton addTarget:self action:@selector(toggleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleButton];
        self.toggleButton.hidden = YES;
//    }
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
- (void)initStreamingSession
{
//    if (self.audioOnly) {
//        self.session = [[PLMediaStreamingSession alloc]
//                        initWithVideoCaptureConfiguration:nil
//                        audioCaptureConfiguration:[PLAudioCaptureConfiguration defaultConfiguration] videoStreamingConfiguration:nil audioStreamingConfiguration:nil stream:nil];
//        self.session.delegate = self;
//    }
//    else {
        self.session = [[PLMediaStreamingSession alloc]
                        initWithVideoCaptureConfiguration:[PLVideoCaptureConfiguration defaultConfiguration]
                        audioCaptureConfiguration:[PLAudioCaptureConfiguration defaultConfiguration] videoStreamingConfiguration:nil audioStreamingConfiguration:nil stream:nil];
        self.session.delegate = self;
        self.session.previewView.frame = self.view.bounds;
        self.fullscreenView = self.session.previewView;
        [self addGestureOnView:self.fullscreenView];
        if (self.userType == PLMediaUserTypeSecondChief) {
            self.toggleButton.hidden = NO;
            [self.view insertSubview:self.session.previewView atIndex:0];
        }
//    }
    
    self.conferenceButton.hidden = NO;
    
//#您需要通过 App 的业务服务器去获取连麦需要的 userID 和 roomToken，此处为了 Demo 演示方便，可以在获取后直接设置下面这两个属性
    self.userID = @"124";
    self.roomToken = @"uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:tPVd1SORxhV8Z1tSqrwXDIA1ncc=:eyJyb29tX25hbWUiOiJ0ZXN0Nzc4IiwidXNlcl9pZCI6IjEyNCIsInBlcm0iOiIxIiwiZXhwaXJlX2F0IjoxNDk0MzE2OTYxfQ==";
}

- (void)initPlayer
{
    if (self.userType == PLMediaUserTypeViewer) {
        PLPlayerOption *option = [PLPlayerOption defaultOption];
        
//#您需要通过 App 的业务服务器去获取播放地址，此处为了 Demo 演示方便，可以直接写死播放地址
        self.player = [PLPlayer playerWithURL:[NSURL URLWithString:@"rtmp://pili-live-rtmp.pili.www.zimu365.com/zimut/zimu3651492680905730A"] option:option];
        self.player.delegate = self;
        if (!self.audioOnly) {
            [self.view addSubview:self.player.playerView];
            [self.view sendSubviewToBack:self.player.playerView];
        }
        [self.player play];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClick:(id)sender
{
    self.session.delegate = nil;
    [self.session destroy];
    self.session = nil;
    
    self.player.delegate = nil;
    self.player = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction)toggleButtonClick:(id)sender
{
    [self.session toggleCamera];
}

- (IBAction)conferenceButtonClick:(id)sender
{
    self.conferenceButton.enabled = NO;
    if (self.userType == PLMediaUserTypeSecondChief) {
        if (!self.conferenceButton.selected) {
            PLRTCConferenceType conferenceType = self.audioOnly ? PLRTCConferenceTypeAudio : PLRTCConferenceTypeAudioAndVideo;
            PLRTCConfiguration *configuration = [[PLRTCConfiguration alloc] initWithVideoSize:PLRTCVideoSizePreset240x432 conferenceType:conferenceType];
            [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:configuration];
            NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
            self.session.rtcOption = option;
            self.session.rtcMinVideoBitrate= 300 * 1000;
            self.session.rtcMaxVideoBitrate= 800 * 1000;
        }
        else {
            [self.session stopConference];
        }
        
        return;
    }
    
    if (self.userType == PLMediaUserTypeViewer) {
        if (!self.conferenceButton.selected) {
            [self.player pause];
            
            if (!self.audioOnly) {
                self.player.playerView.hidden = YES;
                if (!self.session.previewView.superview) {
                    self.session.previewView.frame = self.view.bounds;
                    self.fullscreenView = self.session.previewView;
                    [self.view insertSubview:self.session.previewView atIndex:0];
                }
                self.toggleButton.hidden = NO;
            }
            
            PLRTCConferenceType conferenceType = self.audioOnly ? PLRTCConferenceTypeAudio : PLRTCConferenceTypeAudioAndVideo;
            PLRTCConfiguration *configuration = [[PLRTCConfiguration alloc] initWithVideoSize:PLRTCVideoSizePreset240x432 conferenceType:conferenceType];
            [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:configuration];
            NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
            self.session.rtcOption = option;
            self.session.rtcMinVideoBitrate= 300 * 1000;
            self.session.rtcMaxVideoBitrate= 800 * 1000;
        }
        else {
            [self.session stopConference];
            if (!self.audioOnly) {
                self.toggleButton.hidden = YES;
                if (self.session.previewView.superview) {
                    [self.session.previewView removeFromSuperview];
                }
                self.player.playerView.hidden = NO;
            }
            [self.player play];
        }
        
        return;
    }
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
    NSLog(@"PLMediaViewerViewController dealloc");
}

#pragma mark - observer

- (void)handleApplicationDidEnterBackground:(NSNotification *)notification {
    if (!self.session.isRtcRunning) {
        return;
    }
    
    self.conferenceButton.enabled = YES;
    if (self.userType == PLMediaUserTypeSecondChief) {
        [self.session stopConference];
        return;
    }
    
    if (self.userType == PLMediaUserTypeViewer) {
        [self.session stopConference];
        if (!self.audioOnly) {
            self.toggleButton.hidden = YES;
            if (self.session.previewView.superview) {
                [self.session.previewView removeFromSuperview];
            }
            self.player.playerView.hidden = NO;
        }
        [self.player play];
    }
}

#pragma mark - 大小窗口切换

// 加此手势是为了实现大小窗口切换的功能
- (void)addGestureOnView:(UIView *)view {
    UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewSwiped:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer:recognizer];
}

- (void)animationToFullscreenWithView:(UIView *)view {
    [UIView beginAnimations:@"FrameAni" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationStopped:)];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.frame = self.view.frame;
    [UIView commitAnimations];
}

- (void)animationStopped:(NSString *)aniID {
    self.fullscreenView.frame = self.originRect;
    [self setKickoutButtonHidden:NO onView:self.fullscreenView];
    [self.view sendSubviewToBack:self.tappedView];
    self.fullscreenView = self.tappedView;
}

- (void)viewSwiped:(UITapGestureRecognizer *)gestureRecognizer {
    self.tappedView = gestureRecognizer.view;
    if (CGSizeEqualToSize(self.tappedView.frame.size, self.view.frame.size)) {
        return;
    }
    
    self.originRect = self.tappedView.frame;
    [self setKickoutButtonHidden:YES onView:self.tappedView];
    [self animationToFullscreenWithView:self.tappedView];
}

- (void)setKickoutButtonHidden:(BOOL)hidden onView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            subview.hidden = hidden;
        }
    }
}

#pragma mark - 连麦回调
- (void)startConnect{
    [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:[PLRTCConfiguration defaultConfiguration]];
    NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
    self.session.rtcOption = option;
    self.session.rtcMinVideoBitrate= 300 * 1000;
    self.session.rtcMaxVideoBitrate= 540 * 960;
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session rtcStateDidChange:(PLRTCState)state {
    NSString *log = [NSString stringWithFormat:@"RTC State: %s", rtcStateNames[state]];
    NSLog(@"%@", log);
    self.textView.text = [NSString stringWithFormat:@"%@%@\n", self.textView.text, log];
    
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
    NSInteger space = 0;
    if (!(self.viewSpaceMask & 0x01)) {
        self.viewSpaceMask |= 0x01;
        space = 1;
    }
    else if (!(self.viewSpaceMask & 0x02)) {
        self.viewSpaceMask |= 0x02;
        space = 2;
    }
    else {
        //超出 3 个连麦观众，不再显示。
        return;
    }
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width * 108 / 352.0;
    CGFloat height = screenSize.height * 192 / 640.0;
    remoteView.frame = CGRectMake(0, screenSize.height - height * space - 128, width, height);
    remoteView.clipsToBounds = YES;
    [self.view addSubview:remoteView];
    
    [self addGestureOnView:remoteView];
    
    [self.userViewDictionary setObject:remoteView forKey:userID];
    [self.view bringSubviewToFront:self.conferenceButton];
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session userID:(NSString *)userID didDetachRemoteView:(UIView *)remoteView {
    //如果有做大小窗口切换，当被 Detach 的窗口是全屏窗口时，用 removedPoint 记录自己的预览的窗口的位置，然后把自己的预览的窗口切换成全屏窗口显示
    CGPoint removedPoint = CGPointZero;
    if (remoteView == self.fullscreenView) {
        removedPoint = self.session.previewView.center;
        self.fullscreenView = nil;
        self.tappedView = self.session.previewView;
        [self animationToFullscreenWithView:self.tappedView];
    }
    else {
        removedPoint = remoteView.center;
    }
    
    [remoteView removeFromSuperview];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat height = screenSize.height * 192 / 640.0;
    if (self.view.frame.size.height - removedPoint.y < height) {
        self.viewSpaceMask &= 0xFE;
    }
    else {
        self.viewSpaceMask &= 0xFD;
    }
    
    [self.userViewDictionary removeObjectForKey:userID];
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didKickoutByUserID:(NSString *)userID {
    [self.session stopConference];
    [self showAlertWithMessage:@"您被主播踢出房间了！" completion:^{
        [self backButtonClick:nil];
    }];
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didJoinConferenceOfUserID:(NSString *)userID {
    self.textView.text = [NSString stringWithFormat:@"%@userID: %@ didJoinConference\n", self.textView.text, userID];
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didLeaveConferenceOfUserID:(NSString *)userID {
    self.textView.text = [NSString stringWithFormat:@"%@userID: %@ didLeaveConference\n", self.textView.text, userID];
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
