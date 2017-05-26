//
//  SingleViewerViewController.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PLMediaUserType) {
    PLMediaUserTypeUnknown = 0,
    PLMediaUserTypeSecondChief = 1,
    PLMediaUserTypeViewer = 2
};

@interface SingleViewerViewController : UIViewController
@property (nonatomic, assign) PLMediaUserType userType;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, assign) BOOL audioOnly;
@property (nonatomic, copy) NSString *roomToken;
//@property (nonatomic, copy) NSString *roomName;
@end
