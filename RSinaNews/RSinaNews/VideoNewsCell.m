//
//  VideoNewsCell.m
//  RSinaNews
//
//  Created by TY on 14-6-19.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "VideoNewsCell.h"
#import "ALMoviePlayerController.h"

@interface VideoNewsCell () <ALMoviePlayerControllerDelegate>

@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;
@property (nonatomic) CGRect defaultFrame;

@end

@implementation VideoNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)play:(id)sender {

    self.moviePlayer = [[ALMoviePlayerController alloc] initWithFrame:CGRectMake(0, 0, self.imgView.frame.size.width, self.imgView.frame.size.height)];
    self.moviePlayer.view.alpha = 0.f;
    self.moviePlayer.delegate = self;
    
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:self.moviePlayer style:ALMoviePlayerControlsStyleDefault];
    [movieControls setBarColor:[UIColor colorWithRed:195/255.0 green:29/255.0 blue:29/255.0 alpha:0.5]];
    [movieControls setBarHeight:30];
    [movieControls setTimeRemainingDecrements:YES];
    
    [self.moviePlayer setControls:movieControls];
    
    //    [self.moviePlayer setContentURL:[NSURL URLWithString:self.videoURL]];
    [self addSubview:self.moviePlayer.view];
    [self.moviePlayer stop];
    [self.moviePlayer setContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"popeye" ofType:@"mp4"]]];
    [self.moviePlayer play];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            self.moviePlayer.view.alpha = 1.f;
        } completion:^(BOOL finished) {}];
    });

}

#pragma mark- moviePlayDelegate
- (void)moviePlayerWillMoveFromWindow {
    if (![self.subviews containsObject:self.moviePlayer.view])
        [self addSubview:self.moviePlayer.view];
    [self.moviePlayer setFrame:self.defaultFrame];
}

- (void)movieTimedOut {
    NSLog(@"MOVIE TIMED OUT");
}
@end
