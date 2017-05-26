#import "SingleChiefViewController.h"
#import "PLMediaStreamingKit.h"
#import "PLPlayerKit.h"

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

@interface SingleChiefViewController ()<PLMediaStreamingSessionDelegate, PLPlayerDelegate, FUAPIDemoBarDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>{
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
@property (nonatomic, strong) UIButton *muteButton;
@property (nonatomic, strong) UIButton *conferenceButton;
@property (nonatomic, strong) UIButton *toggleButton;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) PLMediaStreamingSession *session;

@property (nonatomic, assign) NSUInteger viewSpaceMask;

@property (nonatomic, strong) NSMutableDictionary *userViewDictionary;
@property (nonatomic, strong) NSString *    userID;
@property (nonatomic, strong) PLStream *stream;

@property (nonatomic, strong) UIView *fullscreenView;
@property (nonatomic, strong) UIView *tappedView;
@property (nonatomic, assign) CGRect originRect;

//是否已经连麦
@property (nonatomic, assign) BOOL isConnect;
@end

@implementation SingleChiefViewController{
    UIView *_waitView;
}

#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = themeBlack;
    _isConnect = NO;
    [self.navigationController setNavigationBarHidden:YES];
    self.userViewDictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
    [self setupUI];
    [self initStreamingSession];
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
    
//    [self.view addSubview:self.addCustomerBtn];
    [self.view addSubview:self.demoBar];
//    [self.view addSubview:self.barBtn];
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
//    self.actionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, size.height - 66, 66, 66)];
//    [self.actionButton setTitle:@"推流" forState:UIControlStateNormal];
//    [self.actionButton setTitle:@"暂停" forState:UIControlStateSelected];
//    [self.actionButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [self.actionButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.actionButton];
//    self.actionButton.hidden = YES;
//    
//    self.muteButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width / 2 - 33, size.height - 66, 66, 66)];
//    [self.muteButton setTitle:@"静音" forState:UIControlStateNormal];
//    [self.muteButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.muteButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    [self.muteButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.muteButton addTarget:self action:@selector(muteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.muteButton];
//    
//    self.conferenceButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 66 - 20, size.height - 66, 66, 66)];
//    [self.conferenceButton setTitle:@"连麦" forState:UIControlStateNormal];
//    [self.conferenceButton setTitle:@"停止" forState:UIControlStateSelected];
//    [self.conferenceButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.conferenceButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [self.conferenceButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] forState:UIControlStateDisabled];
//    [self.conferenceButton addTarget:self action:@selector(conferenceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.conferenceButton];
//    self.conferenceButton.hidden = YES;
    
    if (self.audioOnly) {
        self.view.backgroundColor = [UIColor blackColor];
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 106, size.width, size.height - 106 * 2)];
        self.textView.editable = NO;
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.textColor = [UIColor whiteColor];
        [self.view addSubview:self.textView];
    }
    else {
        self.toggleButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 66 - 20, 20, 66, 66)];
        [self.toggleButton setTitle:@"切换" forState:UIControlStateNormal];
        [self.toggleButton addTarget:self action:@selector(toggleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleButton];
    }
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat remotewidth = screenSize.width * 108 / 352.0;
    CGFloat remoteHeight = screenSize.height * 192 / 640.0;
    _waitView = [[UIView alloc] initWithFrame:CGRectMake(0, 128, remotewidth, remoteHeight)];
    _waitView.clipsToBounds = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, remoteHeight / 2 - 20, remotewidth, 40)];
    label.text = @"等待对方连接...";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = themeWhite;
    [_waitView addSubview:label];
    _waitView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_waitView];
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


- (void)initStreamingSession
{
    if (self.audioOnly) {
        self.session = [[PLMediaStreamingSession alloc]
                        initWithVideoCaptureConfiguration:nil
                        audioCaptureConfiguration:[PLAudioCaptureConfiguration defaultConfiguration] videoStreamingConfiguration:nil audioStreamingConfiguration:[PLAudioStreamingConfiguration defaultConfiguration] stream:nil];
    }
    else {
        PLVideoStreamingConfiguration *videoStreamingConfiguration = [[PLVideoStreamingConfiguration alloc] initWithVideoSize:CGSizeMake(352, 640) expectedSourceVideoFrameRate:24 videoMaxKeyframeInterval:72 averageVideoBitRate:960 * 540 videoProfileLevel:AVVideoProfileLevelH264HighAutoLevel videoEncoderType:PLH264EncoderType_AVFoundation];
        
        PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
        videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
        videoCaptureConfiguration.sessionPreset = AVCaptureSessionPreset640x480;
        videoCaptureConfiguration.videoOrientation = AVCaptureVideoOrientationPortrait;
        videoCaptureConfiguration.previewMirrorRearFacing = NO;
        videoCaptureConfiguration.streamMirrorRearFacing = NO;
        self.session = [[PLMediaStreamingSession alloc]
                        initWithVideoCaptureConfiguration:videoCaptureConfiguration
                        audioCaptureConfiguration:[PLAudioCaptureConfiguration defaultConfiguration] videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:[PLAudioStreamingConfiguration defaultConfiguration] stream:nil];
        UIImage *waterMark = [UIImage imageNamed:@"qiniu.png"];
        [self.session setWaterMarkWithImage:waterMark position:CGPointMake(100, 100)];
        self.session.previewView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 198);
        self.fullscreenView = self.session.previewView;
        [self addGestureOnView:self.fullscreenView];
        [self.view insertSubview:self.session.previewView atIndex:0];
        [self.session setBeautifyModeOn:YES];
    }
    
    self.session.delegate = self;
    self.actionButton.hidden = NO;
    self.conferenceButton.hidden = NO;
    
//#您需要通过 App 的业务服务器去获取连麦需要的 userID 和 roomToken，此处为了 Demo 演示方便，可以在获取后直接设置下面这两个属性
    self.userID = userToken;
//    self.roomToken = @"uJq2oL4ZqkQrZQgbXelBC_yaVRoRzjoovh_7ubsm:6T9xMws0BUeHWraNKpkckdYrTRQ=:eyJyb29tX25hbWUiOiJ0ZXN0Nzc4IiwidXNlcl9pZCI6IjEiLCJwZXJtIjoidXNlciIsImV4cGlyZV9hdCI6MTQ5NTE4NDg3M30=";
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction)toggleButtonClick:(id)sender
{
    [self.session toggleCamera];
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
                    [self showAlertWithMessage:@"通话失败" completion:^{
                        [self backButtonClick:nil];
                    }];
//                    [self showAlertWithMessage:[NSString stringWithFormat:@"推流失败! feedback is %lu", (unsigned long)feedback] completion:nil];
                }
            });
        }];
    } else {
        [self.session stopStreaming];
        self.actionButton.selected = NO;
    }
    
}
- (IBAction)muteButtonClick:(id)sender
{
    self.muteButton.selected = !self.muteButton.selected;
    self.session.muted = self.muteButton.selected;
}

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

- (IBAction)conferenceButtonClick:(id)sender
{
    self.conferenceButton.enabled = NO;
    
    if (!self.conferenceButton.selected) {
        PLRTCConferenceType conferenceType = self.audioOnly ? PLRTCConferenceTypeAudio : PLRTCConferenceTypeAudioAndVideo;
        PLRTCConfiguration *configuration = [[PLRTCConfiguration alloc] initWithVideoSize:PLRTCVideoSizePreset352x640 conferenceType:conferenceType];
        [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:configuration];
        NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
        self.session.rtcOption = option;
        self.session.rtcMinVideoBitrate= 100 * 1000;
        self.session.rtcMaxVideoBitrate= 300 * 1000;
        self.session.rtcMixOverlayRectArray = [NSArray arrayWithObjects:[NSValue valueWithCGRect:CGRectMake(244, 448, 108, 192)], [NSValue valueWithCGRect:CGRectMake(244, 256, 108, 192)], nil];
    }
    else {
        [self.session stopConference];
    }
    return;
}
//开始连麦
- (void)startConnect{
    if (!_isConnect) {
        [self.session startConferenceWithRoomName:self.roomName userID:self.userID roomToken:self.roomToken rtcConfiguration:[PLRTCConfiguration defaultConfiguration]];
        NSDictionary *option = @{kPLRTCRejoinTimesKey:@(2), kPLRTCConnetTimeoutKey:@(3000)};
        self.session.rtcOption = option;
        self.session.rtcMinVideoBitrate= 300 * 1000;
        self.session.rtcMaxVideoBitrate= 540 * 960;
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
    self.session.delegate = nil;
    [self.session destroy];
    self.session = nil;
    
    fuDestroyAllItems();

    NSLog(@"PLMediaChiefViewController dealloc");
}

#pragma mark - observer

- (void)handleApplicationDidEnterBackground:(NSNotification *)notification {
    if (self.session.isRtcRunning) {
        [self.session stopConference];
        self.conferenceButton.enabled = YES;
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
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 198);
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

#pragma mark - 视频数据回调


#pragma mark - 推流回调

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session streamStateDidChange:(PLStreamState)state {
    NSString *log = [NSString stringWithFormat:@"Stream State: %s", streamStateNames[state]];
    
    NSLog(@"%@", log);
}

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didDisconnectWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    self.actionButton.selected = NO;
    [self showAlertWithMessage:@"通话中断" completion:^{
        [self backButtonClick:nil];
    }];
//    [self showAlertWithMessage:[NSString stringWithFormat:@"Error code: %ld, %@", (long)error.code, error.localizedDescription] completion:nil];
}


/// @abstract 当开始推流时，会每间隔 3s 调用该回调方法来反馈该 3s 内的流状态，包括视频帧率、音频帧率、音视频总码率
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session streamStatusDidUpdate:(PLStreamStatus *)status {
    if (_isConnect) {
        
    }else{
//        [self startConnect];
    }
    NSLog(@"%@", status);
}

#pragma mark - 连麦回调

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session rtcStateDidChange:(PLRTCState)state {
    NSString *log = [NSString stringWithFormat:@"RTC State: %s", rtcStateNames[state]];
    NSLog(@"%@", log);
    self.textView.text = [NSString stringWithFormat:@"%@%@\n", self.textView.text, log];
    
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
//    [self showAlertWithMessage:@"连接断开" completion:^{
//        
//        [self backButtonClick:nil];
//    }];
    [self startConnect];
//    [self showAlertWithMessage:[NSString stringWithFormat:@"Error code: %ld, %@", (long)error.code, error.localizedDescription] completion:^{
//    }];
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
    
    [_waitView removeFromSuperview];
    _waitView = nil;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width * 108 / 352.0;
    CGFloat height = screenSize.height * 192 / 640.0;
    remoteView.frame = CGRectMake(0, 128, width, height);
    remoteView.clipsToBounds = YES;
    [self.view addSubview:remoteView];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width - 40, 0, 40, 40)];
//    [button setTitle:@"踢出" forState:UIControlStateNormal];
//    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [button addTarget:self action:@selector(kickoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [remoteView addSubview:button];
    
    [self addGestureOnView:remoteView];
    
    [self.userViewDictionary setObject:remoteView forKey:userID];
//    [self.view bringSubviewToFront:self.conferenceButton];
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
#pragma mark - faceUnity 代码
- (CVPixelBufferRef)mediaStreamingSession:(PLMediaStreamingSession *)session cameraSourceDidGetPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    
    //    CVPixelBufferRef outputPixelBuffer = [self.pixelBufferProcessor processSourceBuffers:@[[[PLPixelBuffer alloc] initWithCVPixelBuffer:pixelBuffer]]];
    //    CVPixelBufferRef realBuffer = CMSampleBufferGetImageBuffer(pixelBuffer);
    
    //如果当前环境中已存在EAGLContext，此步骤可省略，但必须要调用[EAGLContext setCurrentContext:curContext]函数。
#warning 此步骤不可放在异步线程中执行
//    dispatch_sync(dispatch_get_main_queue(), ^{
        [self setUpContext];
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
//    });
    
    //Faceunity初始化
    
    //加载爱心道具
//    if (items[2] == 0) {
//        [self loadHeart];
//    }
    
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

@end
