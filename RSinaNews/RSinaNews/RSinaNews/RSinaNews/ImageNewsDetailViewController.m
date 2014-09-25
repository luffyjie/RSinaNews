//
//  ImageNewsDetailViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-18.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "ImageNewsDetailViewController.h"
#import "UIImageView+AFNetworking.h"
static const CGFloat kStatusNavHeight = 64.0f;
static const CGFloat kHiddenHeight = 300.0f;

@interface ImageNewsDetailViewController ()
{
    NSArray *_imageList;//图片集
    BOOL _hidden;
    UIBarButtonItem *_likeItem;
    UIBarButtonItem *_favoriteItem;
}
@end

@implementation ImageNewsDetailViewController

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
        _likeItem.image = [[ImageConstant shareImage]navLikeSelectedWhite];
    }
    if ([Tool isFavorited:self.news.contentId]) {
        _favoriteItem.image = [[ImageConstant shareImage]navFavoriteSelectedWhite];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.view.backgroundColor = [UIColor blackColor];
    
    //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navBackWhite] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    //右边按钮组
    _likeItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navLikeNormalWhite] style:UIBarButtonItemStyleBordered target:self action:@selector(like)];
    _favoriteItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navFavoriteNormalWhite] style:UIBarButtonItemStyleBordered target:self action:@selector(favorite)];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navShareNormalWhite] style:UIBarButtonItemStyleBordered target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItems = @[shareItem,_favoriteItem,_likeItem];
    
    //点击隐藏
    UITapGestureRecognizer *tapBG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHidden)];
    tapBG.numberOfTapsRequired = 1;
    tapBG.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapBG];
    //加载图片内容
    [self loadContent];
}
//点击隐藏
- (void)tapHidden
{
    
    if (_hidden) {//出现
        [UIView animateWithDuration:0.5 animations:^{
            [self.navigationController setNavigationBarHidden:NO];
            self.imgScrollView.frame = CGRectMake(self.imgScrollView.frame.origin.x,
                                                  self.imgScrollView.frame.origin.y,
                                                  self.imgScrollView.frame.size.width,
                                                  self.imgScrollView.frame.size.height);
            [self chageOffset:0.0f];
        }];
        _hidden = NO;
    }else{//隐藏
        [UIView animateWithDuration:0.5 animations:^{
            [self.navigationController setNavigationBarHidden:YES];
            self.imgScrollView.frame = CGRectMake(self.imgScrollView.frame.origin.x,
                                                  self.imgScrollView.frame.origin.y+kStatusNavHeight,
                                                  self.imgScrollView.frame.size.width,
                                                  self.imgScrollView.frame.size.height);
            [self chageOffset:kHiddenHeight];
        }];
        _hidden = YES;
    }
}
//隐藏用的，改变y坐标
- (void)chageOffset:(CGFloat)changedY
{
    self.commentView.frame = CGRectMake(self.commentView.frame.origin.x,
                                        self.commentView.frame.origin.y+changedY,
                                        self.commentView.frame.size.width, self.commentView.frame.size.height);
    
    self.lblTitle.frame= CGRectMake(self.lblTitle.frame.origin.x,
                                    self.lblTitle.frame.origin.y+changedY,
                                    self.lblTitle.frame.size.width,
                                    self.lblTitle.frame.size.height);
    
    self.lblCurrentPage.frame = CGRectMake(self.lblCurrentPage.frame.origin.x,
                                           self.lblCurrentPage.frame.origin.y+changedY,
                                           self.lblCurrentPage.frame.size.width,
                                           self.lblCurrentPage.frame.size.height);
    
    self.lblTotalPage.frame = CGRectMake(self.lblTotalPage.frame.origin.x,
                                         self.lblTotalPage.frame.origin.y+changedY,
                                         self.lblTotalPage.frame.size.width,
                                         self.lblTotalPage.frame.size.height);
    
    self.textDescripte.frame = CGRectMake(self.textDescripte.frame.origin.x,
                                          self.textDescripte.frame.origin.y+changedY,
                                          self.textDescripte.frame.size.width,
                                          self.textDescripte.frame.size.height);
}
//加载图片内容
- (void)loadContent
{
    [ImageNews imageNewsWithContentId:self.news.contentId
                             complete:^(ImageNews *news, NSError *error) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     self.newsDetail = news;
                                     self.lblTitle.text = news.title;
                                     self.lblTotalPage.text = [NSString stringWithFormat:@"/%lu",news.imageList.count];
                                     self.lblCommentCount.text = [news.comments stringValue];
                                     _imageList = news.imageList;
                                     OneImage *one = [_imageList objectAtIndex:0];
                                     self.textDescripte.text = one.description;
                                     [self loadScrollView];
                                 });
    }];
}
//加载图片滚动
- (void)loadScrollView
{
    self.imgScrollView.delegate = self;
    CGFloat scrollWidth = self.imgScrollView.frame.size.width;
    CGFloat scrollHeight = self.imgScrollView.frame.size.height;

    self.imgScrollView.multipleTouchEnabled=YES;
    self.imgScrollView.minimumZoomScale=1.0;
    self.imgScrollView.maximumZoomScale=10.0;
    
    NSInteger imgCount = [_imageList count];//图片数
    self.imgScrollView.contentSize = CGSizeMake(scrollWidth*imgCount, scrollHeight);
    //图片
    for (int i=0; i<imgCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollWidth*i, (scrollHeight-300)/2, scrollWidth, 300)];
        OneImage *one = [_imageList objectAtIndex:i];
        [imageView setImageWithURL:one.frURL placeholderImage:[[ImageConstant shareImage]placeholderBig]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imgScrollView addSubview:imageView];
    }
}

#pragma mark- scrollviewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.imgScrollView.frame.size.width;
    int page = self.imgScrollView.contentOffset.x/pagewidth+1;
    if (page>0) {
        self.lblCurrentPage.text = [NSString stringWithFormat:@"%d",page];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.imgScrollView.frame.size.width;
    int page = self.imgScrollView.contentOffset.x/pagewidth;
    OneImage *one = [_imageList objectAtIndex:page];
    self.textDescripte.text = one.description;
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
            _likeItem.image = [[ImageConstant shareImage] navLikeNormalWhite];
        }else{
            [TSMessage showNotificationWithTitle:@"取消关注失败！" type:TSMessageNotificationTypeError];
        }
    }else{
        if ([Tool like:self.news.contentId]) {//添加关注
            _likeItem.image = [[ImageConstant shareImage] navLikeSelectedWhite];
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
            _favoriteItem.image = [[ImageConstant shareImage] navFavoriteNormalWhite];
        }else{
            [TSMessage showNotificationWithTitle:@"取消收藏失败！" type:TSMessageNotificationTypeError];
        }
    }else{
        if ([Tool favorite:self.news.contentId]) {
            _favoriteItem.image = [[ImageConstant shareImage] navFavoriteSelectedWhite];
            [ImageNews saveImageNews:self.newsDetail];
        }else{
            [TSMessage showNotificationWithTitle:@"收藏失败！" type:TSMessageNotificationTypeError];
        }
    }
}

- (void)share
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
