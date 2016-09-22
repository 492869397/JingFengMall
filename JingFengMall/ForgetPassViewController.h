//
//  ForgetPassViewController.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//


@interface ForgetPassViewController : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic)NSTimer *timer;
@property(assign,nonatomic)NSInteger time;

//验证码
@property(copy,nonatomic)NSString *code;

@property (strong, nonatomic) IBOutlet UIButton *vetifyButton;
@property (strong, nonatomic) IBOutlet UITextField *verify;
@property (strong, nonatomic) IBOutlet UITextField *Account;
- (IBAction)confirm:(id)sender;
- (IBAction)getVerify:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *button;

@end
