//
//  MyInfoSetTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyInfoSetTableViewController.h"
#import "MyInfoTextCell.h"
#import "MyInfoPhotoCell.h"
#import "MyInfoNoEditTextCell.h"
#import "EditNickNameTableViewController.h"
#import "EditAgeTableViewController.h"
#import "EditProvinceTableViewController.h"
#import "EditSexTableViewController.h"
#import "MBProgressHUD+MJ.h"
#import "HomeViewController.h"
#import "GetMyInfoAPI.h"
#import "MyInfoModel.h"
#import "CreateTokenApi.h"
#import "QiniuSDK.h"
#import "EditHeadImageApi.h"
#import <UIImageView+WebCache.h>
#import "UIBarButtonItem+ZMExtension.h"

static NSString *textIdentifier = @"MyInfoTextCell";
static NSString *noEditTextIdentifier = @"MyInfoNoEditTextCell";
static NSString *photoIdentifier = @"MyInfoPhotoCell";

@interface MyInfoSetTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIButton *logoutButton;       //退出登录按钮
@property (nonatomic, copy) NSString *qiniuToken;
@property (nonatomic, strong) UIImage *image;       //选择的头像图片

@property (nonatomic, assign) BOOL hasChangeInfo;   //是否修改信息

@end

@implementation MyInfoSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    self.view.backgroundColor = themeGray;
    _hasChangeInfo = NO;
    
    [self.tableView registerClass:[MyInfoTextCell class] forCellReuseIdentifier:textIdentifier];
    [self.tableView registerClass:[MyInfoNoEditTextCell class] forCellReuseIdentifier:noEditTextIdentifier];
    [self.tableView registerClass:[MyInfoPhotoCell class] forCellReuseIdentifier:photoIdentifier];
    [self hideExtraLine];

    [self setupLogoutButton];
    
    //获取七牛token
    [self getQiniuToken];
    
    //监听通知，获取省、市
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedAddress:) name:@"ProvinceCityNotification" object:nil];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProvinceCityNotification" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //修改过我的信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HasChangedMyInfo" object:nil userInfo:nil];
    
}


- (void)selectedAddress:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    MyInfoTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.detailLabel.text = userInfo[@"address"];
    _hasChangeInfo = YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MyInfoPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:photoIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MyInfoPhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:photoIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 10, 0, 0);
        cell.titleLabel.text = @"头像";
        NSString *headImageString = _myInfoModel.userImg;
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[imagePrefixURL stringByAppendingString:headImageString]] placeholderImage:[UIImage imageNamed:@"wode_touxiang"]];
        
        return cell;
    }else if (indexPath.row == 3){
        MyInfoNoEditTextCell *cell = [tableView dequeueReusableCellWithIdentifier:noEditTextIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MyInfoNoEditTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noEditTextIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 10, 0, 0);
        cell.titleLabel.text = @"手机号";
        cell.detailLabel.text = _myInfoModel.userPhone;
        
        return cell;
    }else{
        MyInfoTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MyInfoTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 10, 0, 0);
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"昵称";
            cell.detailLabel.text = _myInfoModel.userName;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"年龄";
            cell.detailLabel.text = [NSString stringWithFormat:@"%@岁",_myInfoModel.age];
        }else if (indexPath.row == 4){
            cell.titleLabel.text = @"性别";
            NSInteger sex = [_myInfoModel.userSex integerValue];
            if (sex == 0) {
                cell.detailLabel.text = @"女";
            }else if(sex == 1){
                cell.detailLabel.text = @"男";
            }
        }else if (indexPath.row == 5){
            cell.titleLabel.text = @"地区";
            cell.detailLabel.text = [NSString stringWithFormat:@"%@ %@",_myInfoModel.provinceName, _myInfoModel.cityName];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        [self callActionSheetFunc];
    }else if (indexPath.row == 1){
        //昵称
        MyInfoTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        EditNickNameTableViewController *editNickNameVC = [[EditNickNameTableViewController alloc]init];
        editNickNameVC.nickNameBlock = ^(NSString *nickName) {
            NSLog(@"昵称 : %@",nickName);
            cell.detailLabel.text = nickName;
            _hasChangeInfo = YES;
        };
        editNickNameVC.nickName = cell.detailLabel.text;
        [self.navigationController pushViewController:editNickNameVC animated:YES];
    }else if (indexPath.row == 2){
        //年龄
        MyInfoTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        EditAgeTableViewController *editAgeVC = [[EditAgeTableViewController alloc]init];
        editAgeVC.ageBlock = ^(NSString *age) {
            NSLog(@"年龄 : %@岁",age);
            cell.detailLabel.text = [NSString stringWithFormat:@"%@岁",age];
            _hasChangeInfo = YES;
        };
        NSString *text = cell.detailLabel.text;
        editAgeVC.ageString = [text substringWithRange:NSMakeRange(0, text.length - 1)];
        [self.navigationController pushViewController:editAgeVC animated:YES];
    }else if (indexPath.row == 4){
        //性别
        MyInfoTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        EditSexTableViewController *editSexVC = [[EditSexTableViewController alloc]init];
        editSexVC.sexBlock = ^(NSString *sex) {
            cell.detailLabel.text = sex;
            _hasChangeInfo = YES;
        };
        editSexVC.sex = cell.detailLabel.text;
        [self.navigationController pushViewController:editSexVC animated:YES];
    }else if (indexPath.row == 5){
        //地区
        EditProvinceTableViewController *editProvinceVC = [[EditProvinceTableViewController alloc]init];
        [self.navigationController pushViewController:editProvinceVC animated:YES];
        
    }
}

- (void)hideExtraLine{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeGray;
    self.tableView.tableFooterView = view;
}






#pragma mark - 选择头像
- (void)callActionSheetFunc{
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //支持相机
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        //不支持相机
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //1.拿到图片后更换头像
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.image = image;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MyInfoPhotoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.headImageView.image = image;

    //2.上传图片名字到服务器
    [self editMyHeadImage];
    
}


#pragma mark - 获取七牛token，上传图片
//上传图片名字到服务器
- (void)editMyHeadImage{
    NSString *imageName = [self getImageName];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    EditHeadImageApi *editHeadImageApi = [[EditHeadImageApi alloc]initWithUserImg:imageName];
    [editHeadImageApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
           [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            
            return;
        }
        
        //3.上传图片到七牛
        NSString *filePath = [self getImagePath:self.image];
        [self uploadImageToQiniu:filePath imageName:imageName];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (NSString *)getImageName{
    NSString *imageName = @"image/";
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    imageName = [imageName stringByAppendingString:dateString];
    int num = (arc4random() % 100) + 900;
    imageName = [NSString stringWithFormat:@"%@%i",imageName, num];
    
    return imageName;
}
//获取七牛token
- (void)getQiniuToken{
    CreateTokenApi *creatTokenApi = [[CreateTokenApi alloc]init];
    [creatTokenApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            
            return;
        }
        _qiniuToken = dataDic[@"object"];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

//上传图片到七牛
- (void)uploadImageToQiniu:(NSString *)filePath imageName:(NSString *)imageName{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil
                                                        progressHandler:^(NSString *key, float percent) {
                                                            NSLog(@"percent == %.2f", percent);
                                                            
                                                        }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    [upManager putFile:filePath key:imageName token:_qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
                option:uploadOption];
}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 0.3);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/myHeadImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}


#pragma mark - 退出登录
- (void)setupLogoutButton{
    _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logoutButton.frame = CGRectMake(kScreenWidth * 0.1, kScreenHeight - 64 - 40 - 20, kScreenWidth * 0.8, 40);
    [_logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    [_logoutButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _logoutButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_logoutButton setBackgroundColor:themeYellow];
    [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logoutButton];
}

- (void)logout{
    [[NSUserDefaults standardUserDefaults] setObject:@"logout" forKey:@"userToken"];
    [MBProgressHUD showMessage_WithoutImage:@"退出登录成功" toView:self.view];
    [self performSelector:@selector(backToHome) withObject:nil afterDelay:0.7];
}
- (void)backToHome{
    NSArray *vcs = self.navigationController.viewControllers;
    
    NSInteger index = 0;
    for (UIViewController *viewController in vcs) {
        if([viewController isKindOfClass:[HomeViewController class]]){
            index = [vcs indexOfObject:viewController];
            break;
        }
    }
    
    [self.navigationController popToViewController:vcs[index] animated:YES];
}



@end
