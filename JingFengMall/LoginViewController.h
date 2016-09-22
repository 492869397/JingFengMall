//
//  LoginViewController.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *account;
@property (strong, nonatomic) IBOutlet UITextField *passWord;

- (IBAction)forgetPassWord:(id)sender;
- (IBAction)regist:(id)sender;
- (IBAction)login:(id)sender;

@property(strong,nonatomic)UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *button;

@end
