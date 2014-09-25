//
//  NewsDetailViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-12.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()
{
    UIBarButtonItem *_likeItem;
    UIBarButtonItem *_favoriteItem;
}
@end

@implementation NewsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //是否收藏关注过
    if ([Tool isLiked:self.news.contentId]) {
        _likeItem.image = [[ImageConstant shareImage]navLikeSelected];
    }
    if ([Tool isFavorited:self.news.contentId]) {
        _favoriteItem.image = [[ImageConstant shareImage]navFavoriteSelected];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navBack] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    //右边按钮组
    _likeItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navLikeNormal] style:UIBarButtonItemStyleBordered target:self action:@selector(like)];
    _favoriteItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navFavoriteNormal] style:UIBarButtonItemStyleBordered target:self action:@selector(favorite)];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navShareNormal] style:UIBarButtonItemStyleBordered target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItems = @[shareItem,_favoriteItem,_likeItem];
    //加载web内容
    [self loadContent];
    
}

- (void)loadContent
{
    [News newsWithContentId:self.news.contentId complete:^(News *news, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsDetail = news;
            self.lblPubDate.text = news.published;
            self.lblSource.text = news.source;
            self.lblTitle.text = news.title;
            [self.contentWebView loadHTMLString:news.content baseURL:nil];
            self.lblCommentCount.text = [news.comments stringValue];
        });
    }];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
//喜欢
- (void)like
{
    if ([Tool isLiked:self.news.contentId]) {//取消关注
        if ([Tool like:self.news.contentId]) {
            _likeItem.image = [[ImageConstant shareImage] navLikeNormal];
        }else{
            [TSMessage showNotificationWithTitle:@"取消关注失败！" type:TSMessageNotificationTypeError];
        }
    }else{
        if ([Tool like:self.news.contentId]) {//添加关注
            _likeItem.image = [[ImageConstant shareImage] navLikeSelected];
        }else{
            [TSMessage showNotificationWithTitle:@"关注失败！" type:TSMessageNotificationTypeError];
        }
    }
}
//收藏
- (void)favorite
{
    if ([Tool isFavorited:self.news.contentId]) {//取消
        if ([Tool favorite:self.news.contentId]) {
            _favoriteItem.image = [[ImageConstant shareImage] navFavoriteNormal];
        }else{
            [TSMessage showNotificationWithTitle:@"取消收藏失败！" type:TSMessageNotificationTypeError];
        }
    }else{
        if ([Tool favorite:self.news.contentId]) {
            [News saveNews:self.newsDetail];//缓存新闻
            _favoriteItem.image = [[ImageConstant shareImage] navFavoriteSelected];
        }else{
            [TSMessage showNotificationWithTitle:@"收藏失败！" type:TSMessageNotificationTypeError];
        }
    }
}
//分享
- (void)share
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
