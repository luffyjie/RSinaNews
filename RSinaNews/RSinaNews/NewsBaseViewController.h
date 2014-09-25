//
//  NewsBaseViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-6.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  新闻展示页

#import <UIKit/UIKit.h>
#import "NewsDetailViewController.h"

@protocol NewsBaseViewControllerDelegate <NSObject>

- (void)pushToNewsDetail:(NewsDetailViewController *)detailVC;//传给NewsViewController做push

@end

@interface NewsBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (assign, nonatomic) id<NewsBaseViewControllerDelegate> pushDelegate;

@property (assign, nonatomic) int category;//类型
@property (assign, nonatomic) int mode;//模式


@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;//图片新闻滑动视图
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;//页数控制

@property (weak, nonatomic) IBOutlet UITableView *tableView;//信息展示


@end

