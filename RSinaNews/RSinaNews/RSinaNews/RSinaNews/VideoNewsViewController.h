//
//  VideoNewsViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  视频新闻页

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"
#import "VideoNewsBaseViewController.h"

@interface VideoNewsViewController : UIViewController<SUNSlideSwitchViewDelegate>

@property (strong, nonatomic) IBOutlet SUNSlideSwitchView *slideSwitchView;

@end
