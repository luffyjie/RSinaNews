//
//  ImageNewsBaseViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-18.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  图片新闻基础

#import <UIKit/UIKit.h>
#import "ImageNewsDetailViewController.h"

@protocol ImageNewsBaseViewControllerDelegate <NSObject>

- (void)pushToImageDetail:(ImageNewsDetailViewController *)detailVC;

@end

@interface ImageNewsBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<ImageNewsBaseViewControllerDelegate> pushDelegate;

@property (assign, nonatomic) int category;//类型
@property (assign, nonatomic) int mode;//模式

@property (strong, nonatomic) IBOutlet UITableView *tableView;//信息展示

@end
