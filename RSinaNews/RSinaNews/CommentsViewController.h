//
//  CommentsViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-25.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  评论列表

#import <UIKit/UIKit.h>
#import "News.h"
@interface CommentsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) News *news;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
