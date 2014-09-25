//
//  CommentsViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-25.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentCell.h"
#import "Comment.h"
#import "MJRefresh.h"


@interface CommentsViewController ()
{
    NSMutableArray *_commentArray;//数据数组
    MJRefreshHeaderView *_header;
}
@end

@implementation CommentsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"全部评论";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    _commentArray = [NSMutableArray array];
    
    //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navBack] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self loadComment];
}
//加载评论
- (void)loadComment
{
    [Comment commentListWithContentId:self.news.contentId complete:^(NSArray *list, NSError *error) {
        _commentArray = [NSMutableArray arrayWithArray:list];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self doneWithView:_header];
        });
    }];
}

#pragma mark-下拉刷新设置
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        [self loadComment];
    };
    [header beginRefreshing];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    [refreshView endRefreshing];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCommentCellIdentifier = @"kCommentCellIdentifier";
    CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:kCommentCellIdentifier];
    if (commentCell == nil) {
        commentCell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCommentCellIdentifier];
    }
    Comment *comment = [_commentArray objectAtIndex:indexPath.row];
    commentCell.lblPubTime.text = comment.published;
    commentCell.textContent.text = comment.content;
    //改变textView的高度
    UITextView *tmpText = commentCell.textContent;
    //相差的高度
    CGFloat subHeight = comment.height-tmpText.frame.size.height;
    if (subHeight > 0) {//大于0说明内容多，以下视图变高/下移
        commentCell.textContent.frame = CGRectMake(commentCell.textContent.frame.origin.x, commentCell.textContent.frame.origin.y, commentCell.textContent.frame.size.width, commentCell.textContent.frame.size.height+subHeight);
        
        commentCell.centerView.frame = CGRectMake(commentCell.centerView.frame.origin.x, commentCell.centerView.frame.origin.y, commentCell.centerView.frame.size.width, commentCell.centerView.frame.size.height+subHeight);
        
        commentCell.imgSupport.frame = CGRectMake(commentCell.imgSupport.frame.origin.x, commentCell.imgSupport.frame.origin.y+subHeight, commentCell.imgSupport.frame.size.width, commentCell.imgSupport.frame.size.height);
        
        commentCell.lblSupport.frame = CGRectMake(commentCell.lblSupport.frame.origin.x, commentCell.lblSupport.frame.origin.y+subHeight, commentCell.lblSupport.frame.size.width, commentCell.lblSupport.frame.size.height);
        
        commentCell.imgReply.frame = CGRectMake(commentCell.imgReply.frame.origin.x, commentCell.imgReply.frame.origin.y+subHeight, commentCell.imgReply.frame.size.width, commentCell.imgReply.frame.size.height);
        
        commentCell.lblReply.frame = CGRectMake(commentCell.lblReply.frame.origin.x, commentCell.lblReply.frame.origin.y+subHeight, commentCell.lblReply.frame.size.width, commentCell.lblReply.frame.size.height);
    }
    return commentCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_commentArray objectAtIndex:indexPath.row];
    CGFloat subHeight = comment.height - 53;//53是textView的原始高度
    if (subHeight>0) {
        return 135 + subHeight;
    }else{
        return 135;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_commentArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
