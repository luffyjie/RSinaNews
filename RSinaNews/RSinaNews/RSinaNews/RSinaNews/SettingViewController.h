//
//  SettingViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  设置页

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *commentView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
