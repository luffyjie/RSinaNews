//
//  VideoNewsBaseViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-19.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "VideoNewsBaseViewController.h"
#import "MJRefresh.h"
#import "News.h"
#import "VideoNewsCell.h"
#import "UIImageView+AFNetworking.h"

static const NSInteger kPagesize = 10;
@interface VideoNewsBaseViewController ()
{
    NSMutableArray *_dataArray;//table数据
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int _allCount;
}
@end


@implementation VideoNewsBaseViewController

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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height-108)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    _dataArray = [NSMutableArray array];
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
    [News newsListWithCatIdAndModelId:self.category
                              modelId:self.mode
                                 page:pageIndex
                             pagesize:kPagesize
                             complete:^(NSArray *list, NSError *error) {
                                 [_dataArray addObjectsFromArray:list];
                                 _allCount+=kPagesize;
                                 [self doneWithView:_header];
                                 [self doneWithView:_footer];
                             }];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kVideoNewsCellIdentifier = @"kVideoNewsCellIdentifier";
    VideoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoNewsCellIdentifier];
    if (cell == nil) {
        NSArray *objs = [[NSBundle mainBundle]loadNibNamed:@"VideoNewsCell" owner:self options:nil];
        cell = (VideoNewsCell*)objs[0];
    }
    if (_dataArray.count > 0) {//不判断会崩溃
        News *news = [_dataArray objectAtIndex:indexPath.row];
        NSURL *imgUrl = [NSURL URLWithString:news.thumb];
        [cell.imgView setImageWithURL:imgUrl placeholderImage:[[ImageConstant shareImage]placeholderBig]];
        cell.lblTitle.text = news.title;
        cell.lblPlayCount.text = [news.comments stringValue];
        cell.videoURL = news.video;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
