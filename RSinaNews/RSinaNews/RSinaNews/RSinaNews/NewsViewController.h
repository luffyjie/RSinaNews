//
//  NewsViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  新闻页

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"
#import "SubscribeViewController.h"
#import "NewsBaseViewController.h"

@interface NewsViewController : UIViewController<SUNSlideSwitchViewDelegate,NewsBaseViewControllerDelegate>

@property (strong, nonatomic) IBOutlet SUNSlideSwitchView *slideSwitchView;

@end
