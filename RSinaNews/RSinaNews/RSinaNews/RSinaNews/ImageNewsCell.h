//
//  ImageNewsCell.h
//  RSinaNews
//
//  Created by TY on 14-6-17.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  图片新闻cell

#import <UIKit/UIKit.h>

@interface ImageNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblImgCount;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentCount;


@end
