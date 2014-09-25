//
//  VideoNewsBaseViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-19.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoNewsBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) int category;//类型
@property (assign, nonatomic) int mode;//模式

@property (strong, nonatomic) IBOutlet UITableView *tableView;//信息展示

@end
