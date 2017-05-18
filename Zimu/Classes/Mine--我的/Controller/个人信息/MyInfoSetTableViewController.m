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

static NSString *textIdentifier = @"MyInfoTextCell";
static NSString *noEditTextIdentifier = @"MyInfoNoEditTextCell";
static NSString *photoIdentifier = @"MyInfoPhotoCell";

@interface MyInfoSetTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIButton *logoutButton;       //退出登录按钮

@end

@implementation MyInfoSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    self.view.backgroundColor = themeGray;
    
    [self.tableView registerClass:[MyInfoTextCell class] forCellReuseIdentifier:textIdentifier];
    [self.tableView registerClass:[MyInfoNoEditTextCell class] forCellReuseIdentifier:noEditTextIdentifier];
    [self.tableView registerClass:[MyInfoPhotoCell class] forCellReuseIdentifier:photoIdentifier];
    [self hideExtraLine];
    
    [self setupLogoutButton];
    
    //监听通知，获取省、市
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedAddress:) name:@"ProvinceCityNotification" object:nil];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProvinceCityNotification" object:nil];
}

- (void)selectedAddress:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    MyInfoTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.detailLabel.text = userInfo[@"address"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        return cell;
    }else if (indexPath.row == 3){
        MyInfoNoEditTextCell *cell = [tableView dequeueReusableCellWithIdentifier:noEditTextIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MyInfoNoEditTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noEditTextIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 10, 0, 0);
        cell.titleLabel.text = @"手机号";
        cell.detailLabel.text = @"15757164712";
        
        return cell;
    }
    MyInfoTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyInfoTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 10, 0, 0);
    if (indexPath.row == 1) {
        cell.titleLabel.text = @"昵称";
        cell.detailLabel.text = @"小公举";
    }else if (indexPath.row == 2){
        cell.titleLabel.text = @"年龄";
        cell.detailLabel.text = @"8岁";
    }else if (indexPath.row == 4){
        cell.titleLabel.text = @"性别";
        cell.detailLabel.text = @"男";
    }else if (indexPath.row == 5){
        cell.titleLabel.text = @"地区";
        cell.detailLabel.text = @"";
    }
    
    return cell;
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
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MyInfoPhotoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.headImageView.image = image;
    NSData *data = UIImageJPEGRepresentation(image, 0.1f);
    //    NSString *dtr = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"length : %li", (unsigned long)encodedImageStr.length);
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
