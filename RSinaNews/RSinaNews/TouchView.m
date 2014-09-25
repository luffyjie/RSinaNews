//
//  TouchView.m
//  TouchDemo
//
//  Created by Zer0 on 13-8-11.
//  Copyright (c) 2013年 Zer0. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label = l;
        _sign = 0;
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.label setFrame:CGRectMake(1, 1, KButtonWidth - 2, KButtonHeight - 2)];
    [self.label setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [self addSubview:self.label];
    
}
#pragma mark- 触摸事件处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    
    _point = [touch locationInView:self];//自己的坐标
    _point2 = [touch locationInView:self.superview];//父视图的坐标
    
    [self.superview exchangeSubviewAtIndex:[self.superview.subviews indexOfObject:self] withSubviewAtIndex:[[self.superview subviews] count] - 1];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    int a = point.x - _point.x;
    int b = point.y - _point.y;
    
    
    if (![self.label.text isEqualToString:@"头条"]) {
        [self.label setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
        [self setImage:nil];
        
        if (_sign == 0) {
            if (_array == _viewArr11) {
                [_viewArr11 removeObject:self];
                [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                _array = _viewArr22;
                [self animationAction];
            }
            else if ( _array == _viewArr22){
                [_viewArr22 removeObject:self];
                [_viewArr11 insertObject:self atIndex:_viewArr11.count];
                _array = _viewArr11;
                [self animationAction];
            }
        }
        else if (([self buttonInArrayArea1:_viewArr11 Point:point] || [self buttonInArrayArea2:_viewArr22 Point:point])&&!(point.x - _point.x > KTableStartPointX && point.x - _point.x < KTableStartPointX + KButtonWidth && point.y - _point.y > KTableStartPointY && point.y - _point.y < KTableStartPointY + KButtonHeight)){
            if (point.x < KTableStartPointX || point.y < KTableStartPointY) {
                [self setFrame:CGRectMake(_point2.x - _point.x, _point2.y - _point.y, self.frame.size.width, self.frame.size.height)];
            }
            else{
                [self setFrame:CGRectMake(KTableStartPointX + (a + KButtonWidth/2 - KTableStartPointX)/KButtonWidth*KButtonWidth, KTableStartPointY + (b + KButtonHeight/2 - KTableStartPointY)/KButtonHeight*KButtonHeight, self.frame.size.width, self.frame.size.height)];
            }
            
        }
        else{
            
            [self animationAction];
            
        }
        _sign = 0;
    }
    [self.label setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [self setImage:nil];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _sign = 1;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    if (![self.label.text isEqualToString:@"头条"]) {
        [self.label setBackgroundColor:[UIColor clearColor]];
        [self setImage:[UIImage imageNamed:@"order_drag_move_bg.png"]];
        [self setFrame:CGRectMake( point.x - _point.x, point.y - _point.y, self.frame.size.width, self.frame.size.height)];
        
        CGFloat newX = point.x - _point.x + KButtonWidth/2;
        CGFloat newY = point.y - _point.y + KButtonHeight/2;
        
//        if (!CGRectContainsPoint([[_viewArr11 objectAtIndex:0] frame], CGPointMake(newX, newY)) ) { //区域1中的第一个按钮
        
            if ( _array == _viewArr22) {
                
                if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
                    
                    int index = ((int)newX - KTableStartPointX)/KButtonWidth + (kColumnCount * (((int)newY - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:index];
                    _array = _viewArr11;
                    [self animationAction1a];
                    [self animationAction2];
                }
                else if (newY < KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea1:_viewArr11 Point:point]){
                    
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:_viewArr11.count];
                    _array = _viewArr11;
                    [self animationAction2];
                    
                }
                else if([self buttonInArrayArea2:_viewArr22 Point:point]){
                    unsigned long index = ((unsigned long )(newX) - KTableStartPointX)/KButtonWidth + (kColumnCount * (((int)(newY) - [self array2StartY] * KButtonHeight - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:index];
                    [self animationAction2a];
                    
                }
                else if(newY > KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea2:_viewArr22 Point:point]){
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                    [self animationAction2a];
                    
                }
            }
            else if ( _array == _viewArr11) {
                if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
                    int index = ((int)newX - KTableStartPointX)/KButtonWidth + (kColumnCount * (((int)(newY) - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:index];
                    _array = _viewArr11;
                    
                    [self animationAction1a];
//                    [self animationAction2];
                }
                else if (newY < KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea1:_viewArr11 Point:point]){
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex: _array.count];
                    [self animationAction1a];
                    [self animationAction2];
                }
                else if([self buttonInArrayArea2:_viewArr22 Point:point]){
                    unsigned long index = ((unsigned long)(newX) - KTableStartPointX)/KButtonWidth + (kColumnCount * (((int)(newY) - [self array2StartY] * KButtonHeight - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:index];
                    _array = _viewArr22;
                    [self animationAction2a];
                }
                else if(newY > KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea2:_viewArr22 Point:point]){
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                    _array = _viewArr22;
                    [self animationAction2a];
                    
                }
            }
        }
//    }
}

#pragma mark-动画
- (void)animationAction1{//从新排列1视图的按钮
    for (int i = 0; i < _viewArr11.count; i++) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
            [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%kColumnCount) * KButtonWidth, KTableStartPointY + (i/kColumnCount)* KButtonHeight, KButtonWidth, KButtonHeight)];
        } completion:^(BOOL finished){
                
        }];
    }
}
- (void)animationAction1a{//从新排列1视图中除开自己的按钮
    for (int i = 0; i < _viewArr11.count; i++) {
        if ([_viewArr11 objectAtIndex:i] != self) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%kColumnCount) * KButtonWidth, KTableStartPointY + (i/kColumnCount)* KButtonHeight, KButtonWidth, KButtonHeight)];
            } completion:^(BOOL finished){
                
            }];
        }
    }
    
}
- (void)animationAction2{//从新排列2视图中的那妞
    for (int i = 0; i < _viewArr22.count; i++) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%kColumnCount) * KButtonWidth, KTableStartPointY + [self array2StartY] * KButtonHeight + (i/kColumnCount)* KButtonHeight, KButtonWidth, KButtonHeight)];
            
        } completion:^(BOOL finished){
            
        }];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
}
- (void)animationAction2a{//从新排列2区域，除开自己的按钮
    for (int i = 0; i < _viewArr22.count; i++) {
        if ([_viewArr22 objectAtIndex:i] != self) {
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                
                [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%kColumnCount) * KButtonWidth, KTableStartPointY + [self array2StartY] * KButtonHeight + (i/kColumnCount)* KButtonHeight, KButtonWidth, KButtonHeight)];
                
            } completion:^(BOOL finished){
            }];
        }
        
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
}

#pragma mark-点击的移动动画
- (void)animationAction{
    for (int i = 0; i < _viewArr11.count; i++) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%kColumnCount) * KButtonWidth, KTableStartPointY + (i/kColumnCount)* KButtonHeight, KButtonWidth, KButtonHeight)];
        } completion:^(BOOL finished){
            
        }];
    }
    for (int i = 0; i < _viewArr22.count; i++) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%kColumnCount) * KButtonWidth, KTableStartPointY + [self array2StartY] * KButtonHeight + (i/kColumnCount)* KButtonHeight, KButtonWidth, KButtonHeight)];
            
        } completion:^(BOOL finished){
            
        }];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
    
}
#pragma mark-判断按钮所在区域
- (BOOL)buttonInArrayArea1:(NSMutableArray *)arr Point:(CGPoint)point{
    CGFloat newX = point.x - _point.x + KButtonWidth/2;
    CGFloat newY = point.y - _point.y + KButtonHeight/2;
    int a =  arr.count%kColumnCount;
    unsigned long b =  arr.count/kColumnCount;
    if ((newX > KTableStartPointX && newX < KTableStartPointX + kColumnCount * KButtonWidth && newY > KTableStartPointY && newY < KTableStartPointY + b * KButtonHeight) || (newX > KTableStartPointX && newX < KTableStartPointX + a * KButtonWidth && newY > KTableStartPointY + b * KButtonHeight && newY < KTableStartPointY + (b+1) * KButtonHeight) ) {
        return YES;
    }
    return NO;
}
- (BOOL)buttonInArrayArea2:(NSMutableArray *)arr Point:(CGPoint)point{
    CGFloat newX = point.x - _point.x + KButtonWidth/2;
    CGFloat newY = point.y - _point.y + KButtonHeight/2;
    int a =  arr.count%kColumnCount;
    unsigned long b =  arr.count/kColumnCount;
    if ((newX > KTableStartPointX && newX < KTableStartPointX + kColumnCount * KButtonWidth && newY > KTableStartPointY + [self array2StartY] * KButtonHeight && newY < KTableStartPointY + (b + [self array2StartY]) * KButtonHeight) || (newX > KTableStartPointX && newX < KTableStartPointX + a * KButtonWidth && newY > KTableStartPointY + (b + [self array2StartY]) * KButtonHeight && newY < KTableStartPointY + (b+[self array2StartY]+1) * KButtonHeight) ) {
        return YES;
    }
    return NO;
}
- (unsigned long)array2StartY{
    unsigned long y = 0;
    
//    y = _viewArr11.count/kColumnCount + 2;
//    if (_viewArr11.count%kColumnCount == 0) {
//        y -= 1;
//    }
    y = 7;//button高度乘以7，相当于210的距离
    return y;
}

@end
