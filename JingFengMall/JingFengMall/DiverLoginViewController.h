//
//  DiverLoginViewController.h
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//


@interface DiverLoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;

@property (strong, nonatomic) IBOutlet UITextField *account;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)regist:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)forgetPassWord:(id)sender;

@end
