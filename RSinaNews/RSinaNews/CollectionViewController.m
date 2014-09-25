//
//  CollectionViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-23.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "CollectionViewController.h"
#import "User.h"
#import "News.h"
#import "NewsDetailViewController.h"
#import "ImageNewsDetailViewController.h"

@interface CollectionViewController ()
{
    NSMutableArray *_collectionArray;//收藏列表
}
@end

@implementation CollectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"收藏";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navBack]
                                                                style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _collectionArray = [NSMutableArray array];
    [self loadCollection];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//加载收藏
- (void)loadCollection
{
    DatabaseManager *db = [DatabaseManager sharedDatabase];
    [db open];
    User *u = [Tool getUser];
    NSString *selectSql = @"select news.contentid,news.title,news.published,news.modelid from userCollection,news where userCollection.contentid = news.contentid and userid=?";
    FMResultSet *set = [db executeQuery:selectSql,u.userId];
    while ([set next]) {
        News *n = [[News alloc]init];
        n.contentId = [set objectForColumnName:@"contentid"];
        n.title = [set objectForColumnName:@"title"];
        n.published = [set objectForColumnName:@"published"];
        n.modelId = [set objectForColumnName:@"modelid"];
        [_collectionArray addObject:n];
    }
    [db close];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_collectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCollectionCellIdentifier = @"kCollectionCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCollectionCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCollectionCellIdentifier];
    }
    News *n = [_collectionArray objectAtIndex:indexPath.row];
    NSString *time = [n.published substringWithRange:NSMakeRange(0,10)];
    cell.textLabel.text = n.title;
    cell.detailTextLabel.text = time;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *n = [_collectionArray objectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {//删除收藏
        DatabaseManager *db = [DatabaseManager sharedDatabase];
        [db open];
        User *u = [Tool getUser];
        NSString *deleteSql = @"delete from userCollection where userid=? and contentid=?";
        [db executeUpdate:deleteSql,u.userId,n.contentId];
        [db close];
        [_collectionArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}


#pragma mark - Table view delegate
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    News *n = [_collectionArray objectAtIndex:indexPath.row];
    if ([n.modelId isEqual:[NSNumber numberWithInt:NewsModelImages]]) {//是图片新闻类型
        ImageNewsDetailViewController *imgDetail = [[ImageNewsDetailViewController alloc]init];
        imgDetail.news = (ImageNews*)n;
        [self.navigationController pushViewController:imgDetail animated:YES];
    }else{//文本新闻
        NewsDetailViewController *newsDetail = [[NewsDetailViewController alloc]init];
        newsDetail.news = n;
        [self.navigationController pushViewController:newsDetail animated:YES];
    }
    
}


@end
