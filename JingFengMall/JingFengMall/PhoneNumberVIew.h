//
//  PhoneNumberVIew.h
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//


@interface PhoneNumberVIew : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic)NSMutableDictionary *pass;

@property (strong, nonatomic) IBOutlet UITextField *Account;
- (IBAction)confirm:(id)sender;

@end
