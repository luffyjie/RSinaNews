//
//  ImageNewsViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  图片新闻页

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"
#import "ImageNewsBaseViewController.h"

@interface ImageNewsViewController : UIViewController<SUNSlideSwitchViewDelegate,ImageNewsBaseViewControllerDelegate>

@property (strong, nonatomic) IBOutlet SUNSlideSwitchView *slideSwitchView;

@end
