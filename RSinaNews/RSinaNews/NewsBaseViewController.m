//
//  NewsBaseViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-6.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "NewsBaseViewController.h"
#import "MJRefresh.h"
#import "News.h"
#import "UIImageView+AFNetworking.h"
#import "NewsCell.h"

static const NSInteger kPagesize = 10;
static const NSInteger kScrollImageCount = 4;
@interface NewsBaseViewController ()
{
    NSMutableArray *_dataArray;//table数据
    NSMutableArray *_imageArray;//scroll数据
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int _allCount;
}
@end

@implementation NewsBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //page设置
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(240, 120, 80, 20)];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.userInteractionEnabled = NO;
    [self.tableView addSubview:self.pageControl];
    
    [self addHeader];
    [self addFooter];
    
}


#pragma mark-上下拉刷新设置
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        [self reload:YES];
    };
    [header beginRefreshing];
    _header = header;
}
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        [self reload:NO];
    };
    _footer = footer;
}

// isRefresh NO表示加载更多  YES表示刷新最新
- (void)reload:(BOOL)isRefresh
{
    if (isRefresh) {
        [self clear];
    }
    int pageIndex = _allCount/kPagesize+1;
    if (!self.mode) {//按类型加载
        [News newsListWithCatId:self.category page:pageIndex pagesize:kPagesize complete:^(NSArray *list, NSError *error) {
            [_dataArray addObjectsFromArray:list];
            _allCount+=kPagesize;
            [self doneWithView:_header];
            [self doneWithView:_footer];
            
            [self loadImageScrollView];
        }];
    }else{//按模型加载
        [News newsListWithModelId:self.mode page:pageIndex pagesize:kPagesize complete:^(NSArray *list, NSError *error) {
            [_dataArray addObjectsFromArray:list];
            _allCount+=kPagesize;
            [self doneWithView:_header];
            [self doneWithView:_footer];
            
            [self loadImageScrollView];
        }];
    }
}
//清空
- (void)clear
{
    _allCount = 0;
    [_dataArray removeAllObjects];
}
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    [refreshView endRefreshing];
}


#pragma mark-tableView设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count]-kScrollImageCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kNewsCellIdentifier = @"kNewsCellIdentifier";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewsCellIdentifier];
    if (cell == nil) {
        NSArray *objs = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:self options:nil];
        cell = (NewsCell*)objs[0];
    }
    
    if (_dataArray.count > 0) {//不判断会崩溃
        //加载kScrollImageCount之后的新闻
        News *news = [_dataArray objectAtIndex:(indexPath.row+kScrollImageCount)];
        NSURL *imgUrl = [NSURL URLWithString:news.thumb];
        [cell.imgView setImageWithURL:imgUrl placeholderImage:[[ImageConstant shareImage]placeholderCell]];
        cell.lblTitle.text = news.title;
        cell.lblSubtitle.text = news.description;
        cell.lblComments.text = [news.comments stringValue];
        if (news.video.length==0 || [news.video isEqualToString:@""]) {
            cell.imgVideo.hidden = YES;
            cell.lblVideo.hidden = YES;
        }else{
            cell.imgVideo.hidden = NO;
            cell.lblVideo.hidden = NO;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsDetailViewController *detailVC = [[NewsDetailViewController alloc]init];
    detailVC.news = [_dataArray objectAtIndex:(indexPath.row+kScrollImageCount)];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.pushDelegate pushToNewsDetail:detailVC];
}


#pragma  mark- 滚动视图设置
- (void)loadImageScrollView
{
    NSUInteger scrollWidth = self.imageScrollView.frame.size.width;
    NSUInteger scrollHeight = self.imageScrollView.frame.size.height;
    //清空刷新前的数据
    NSArray *subViews = self.imageScrollView.subviews;
    for (UIView *v in subViews) {
        [v removeFromSuperview];
    }
    [_imageArray removeAllObjects];
    
    //用数据的前四张
    for (int i=0; i<kScrollImageCount; i++) {
        News *n = [_dataArray objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:n.thumb];
        [_imageArray addObject:url];
    }
    
    self.pageControl.numberOfPages = [_imageArray count];
    self.pageControl.currentPage = 0;
    
    // 创建中间几张图片 imageview
    for (int i = 0;i<[_imageArray count];i++)
    {
        [self.imageScrollView addSubview:[self loadImageAndTitle:((scrollWidth * i) + scrollWidth) index:i]];
    }
    
    // 取数组最后一张图片 放在第0页
    [self.imageScrollView addSubview:[self loadImageAndTitle:0 index:([_imageArray count]-1)]];
    
    // 取数组第一张图片 放在最后1页
    [self.imageScrollView addSubview:[self loadImageAndTitle:(scrollWidth * ([_imageArray count] + 1)) index:0]];
    
    [self.imageScrollView setContentSize:CGSizeMake(scrollWidth * ([_imageArray count] + 2), scrollHeight)];
    [self.imageScrollView setContentOffset:CGPointMake(0, 0)];
    [self.imageScrollView scrollRectToVisible:CGRectMake(scrollWidth,0,scrollWidth,scrollHeight) animated:NO];
    self.imageScrollView.delegate = self;
}

//加载标题和红线,把x坐标和图片index传过来加载一个view
- (UIView *)loadImageAndTitle:(CGFloat)x index:(NSInteger)index
{
    NSUInteger scrollWidth = self.imageScrollView.frame.size.width;
    NSUInteger scrollHeight = self.imageScrollView.frame.size.height;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, 0, scrollWidth, scrollHeight)];
    //图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight-28)];
    [imageView setImageWithURL:[_imageArray objectAtIndex:index] placeholderImage:[[ImageConstant shareImage]placeholderBig]];
    [view addSubview:imageView];
    //标题
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(10, 155, 300, 22)];
    News *n = [_dataArray objectAtIndex:index];
    titleView.text = [NSString stringWithFormat:@"%@",n.title];
    titleView.font = [UIFont fontWithName:@"HeiTi SC" size:14];
    titleView.textColor = [UIColor blackColor];
    [view addSubview:titleView];
    //红线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 179, 300, 1)];
    lineView.backgroundColor = [UIColor redColor];
    [view addSubview:lineView];
    
    UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg)];
    tapImg.numberOfTapsRequired = 1;
    tapImg.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tapImg];
    return view;
}

// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.imageScrollView.frame.size.width;
    int page = floor((self.imageScrollView.contentOffset.x - pagewidth/([_imageArray count]+2))/pagewidth)+1;
    page --;
    self.pageControl.currentPage = page;
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger scrollWidth = self.imageScrollView.frame.size.width;
    NSUInteger scrollHeight = self.imageScrollView.frame.size.height;
    CGFloat pagewidth = self.imageScrollView.frame.size.width;
    int currentPage = floor((self.imageScrollView.contentOffset.x - pagewidth/ ([_imageArray count]+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [self.imageScrollView scrollRectToVisible:CGRectMake(scrollWidth * [_imageArray count],0,scrollWidth,scrollHeight) animated:NO];
    }
    else if (currentPage==([_imageArray count]+1))
    {
        [self.imageScrollView scrollRectToVisible:CGRectMake(scrollWidth,0,scrollWidth,scrollHeight) animated:NO];
    }
}


-(void)tapImg
{
    NewsDetailViewController *detailVC = [[NewsDetailViewController alloc]init];
    
    detailVC.news = [_dataArray objectAtIndex:self.pageControl.currentPage];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.pushDelegate pushToNewsDetail:detailVC];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
