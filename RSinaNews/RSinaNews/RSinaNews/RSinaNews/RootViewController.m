//
//  RootViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "RootViewController.h"
#import "NewsViewController.h"
#import "ImageNewsViewController.h"
#import "VideoNewsViewController.h"
#import "SettingViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    ImageNewsViewController *imageVC = [[ImageNewsViewController alloc]init];
    VideoNewsViewController *videoVC = [[VideoNewsViewController alloc]init];
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    UINavigationController *newsNav = [[UINavigationController alloc]initWithRootViewController:newsVC];
    UINavigationController *imageNav = [[UINavigationController alloc]initWithRootViewController:imageVC];
    UINavigationController *videoNav = [[UINavigationController alloc]initWithRootViewController:videoVC];
    UINavigationController *settingNav = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    [self setViewControllers:@[newsNav,imageNav,videoNav,settingNav] animated:NO];
    self.tabBar.tintColor = [UIColor redColor];

    //提醒的默认control设置
    [TSMessage setDefaultViewController:self];
    [self checkNet];
}

- (void)checkNet
{
    //判断网络
    AFNetworkReachabilityStatus status = [[[APIClient shareClient]reachabilityManager]networkReachabilityStatus];
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            [TSMessage showNotificationWithTitle:@"网络不给力!" type:TSMessageNotificationTypeSuccess];
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            [TSMessage showNotificationWithTitle:@"正在用wifi" type:TSMessageNotificationTypeSuccess];
            break;
        case AFNetworkReachabilityStatusUnknown:
            [TSMessage showNotificationWithTitle:@"局域网" type:TSMessageNotificationTypeSuccess];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end


