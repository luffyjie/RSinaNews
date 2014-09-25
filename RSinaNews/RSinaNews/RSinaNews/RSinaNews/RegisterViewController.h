//
//  RegisterViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-16.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  注册页面

#import <UIKit/UIKit.h>
#import "User.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UITextField *textRepassword;
@property (weak, nonatomic) IBOutlet UITextField *textMphone;
@property (weak, nonatomic) IBOutlet UITextField *textNickname;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmGender;


- (IBAction)cancel:(id)sender;
- (IBAction)registerClick:(id)sender;

@end
