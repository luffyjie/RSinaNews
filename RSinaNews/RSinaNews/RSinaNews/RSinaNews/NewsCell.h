//
//  NewsCell.h
//  RSinaNews
//
//  Created by TY on 14-6-12.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  新闻tableCell

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblComments;

@property (weak, nonatomic) IBOutlet UIImageView *imgVideo;
@property (weak, nonatomic) IBOutlet UILabel *lblVideo;

@end
