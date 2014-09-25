//
//  VideoNewsCell.h
//  RSinaNews
//
//  Created by TY on 14-6-19.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  视频新闻cell

#import <UIKit/UIKit.h>

@interface VideoNewsCell : UITableViewCell

@property (nonatomic, strong) NSString *videoURL;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayCount;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

- (IBAction)play:(id)sender;//播放按钮

@end
