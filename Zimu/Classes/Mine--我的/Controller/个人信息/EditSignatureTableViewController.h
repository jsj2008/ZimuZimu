//
//  EditSignatureTableViewController.h
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SignatureBlock)(NSString *);


@interface EditSignatureTableViewController : UITableViewController

@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) SignatureBlock signatureBlock;

@end
