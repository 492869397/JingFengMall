//
//  CarMainViewController.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "AdScrollView.h"

@interface CarMainViewController : UIViewController

@property (strong, nonatomic) IBOutlet AdScrollView *scrollView;

- (IBAction)getCar:(id)sender;
- (IBAction)carOwner:(id)sender;
- (IBAction)enterHistory:(id)sender;


@end
