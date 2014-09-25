//
//  SettingViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "User.h"
#import "CollectionViewController.h"

@interface SettingViewController ()
{
    NSDictionary *_settingDict;
    UISwitch *_nightSwitch;
    UISwitch *_headNewsSwitch;
    UISwitch *_imageDownloadSwitch;
}
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"设置"
                                                       image:[[ImageConstant shareImage]tabSetting]
                                               selectedImage:[[ImageConstant shareImage]tabSettingSelected]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    User *user = [Tool getUser];//判断用户是否登录
    if (user) {
        self.lblUserName.text = user.email;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //设置每个section对应的内容
    NSArray *array1 = @[@"离线下载",@"夜间模式",@"头条推送",@"2G/3G不下载图片",@"离线设置",@"正文字号",
                        @"清除缓存"];
    NSArray *array2 = @[@"反馈",@"版本",@"关于"];
    NSArray *array3=@[@"应用中心"];
    _settingDict = @{@0:array1,@1:array2,@2:array3};
    
    //switch加载
    _nightSwitch = [[UISwitch alloc]init];
    _headNewsSwitch = [[UISwitch alloc]init];
    _imageDownloadSwitch = [[UISwitch alloc]init];
    
    //按钮点击
    UITapGestureRecognizer *tapLogin = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(loginTaped)];
    [self.loginView addGestureRecognizer:tapLogin];
    
    UITapGestureRecognizer *tapCollection = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(collectionTaped)];
    [self.collectionView addGestureRecognizer:tapCollection];
    
    UITapGestureRecognizer *tapComment = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(commentTaped)];
    [self.commentView addGestureRecognizer:tapComment];
}

#pragma mark- 登录点击
- (void)loginTaped
{
    if ([Tool getUser]) {//已经登录，，点击注销
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"真的要注销吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
//点击收藏
- (void)collectionTaped
{
    if ([Tool getUser]) {
        CollectionViewController *collectionVC = [[CollectionViewController alloc]init];
        collectionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
}
//点击评论
- (void)commentTaped
{
    
}

#pragma mark- tableView设置
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kSettingCellIdentifier = @"kSettingCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSettingCellIdentifier];
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];
    //根据section加载具体设置信息
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[_settingDict objectForKey:@0]objectAtIndex:indexPath.row];
            //switch开关设置
            switch (indexPath.row) {
                case 0:
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case 1:
                    cell.accessoryView = _nightSwitch;
                    break;
                case 2:
                    cell.accessoryView = _headNewsSwitch;
                    break;
                case 3:
                    cell.accessoryView = _imageDownloadSwitch;
                    break;
                case 4:
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case 5:
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    cell.detailTextLabel.text = @"中";
                    break;
                case 6:
                    cell.detailTextLabel.text = @"1M";
                    break;
                default:
                    break;
            }
            
            break;
        case 1:
            cell.textLabel.text = [[_settingDict objectForKey:@1]objectAtIndex:indexPath.row];
            if (indexPath.row==0 || indexPath.row == 2) {
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }else{
                cell.detailTextLabel.text = @"1.0.1";
            }
            break;
        case 2:
            cell.textLabel.text = [[_settingDict objectForKey:@2]objectAtIndex:indexPath.row];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        default:
            break;
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [[_settingDict objectForKey:@0]count];
        case 1:
            return [[_settingDict objectForKey:@1]count];
        case 2:
            return [[_settingDict objectForKey:@2]count];
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 20;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- alertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {//确定
        [Tool logOut];
        self.lblUserName.text = @"登录账号";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
