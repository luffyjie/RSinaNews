//
//  LoginViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-16.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  登录界面

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textUsername;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;

- (IBAction)clickRegister:(id)sender;
- (IBAction)clickLogin:(id)sender;

- (IBAction)cancel:(id)sender;
@end
