//
//  ChangeViewController.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

@interface ChangeViewController : UIViewController<UITextFieldDelegate>

@property(copy,nonatomic)NSString *account;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UITextField *passWord2;
- (IBAction)confirm:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *button;

@end
