//
//  NewsDetailViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-12.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  新闻详细页

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsDetailViewController : UIViewController

@property (nonatomic, strong) News *news;//push过来的新闻内容
@property (nonatomic, strong) News *newsDetail;//网络请求的新闻详情

@property (weak, nonatomic) IBOutlet UILabel *lblPubDate;
@property (weak, nonatomic) IBOutlet UILabel *lblSource;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;


@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentCount;//评论数
@property (weak, nonatomic) IBOutlet UIView *commentsShow;//点击显示全部评论


@end
